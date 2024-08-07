"
A Tile effect generator for Board initialization
"
Class {
	#name : #TileEffectsCreator,
	#superclass : #Object,
	#instVars : [
		'probabilityEffects',
		'tiles',
		'parsecs',
		'hyperJumpArray',
		'probabilityManager'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
TileEffectsCreator class >> createWithProbabilityDistribution: aProbabilityDistributionCollection [

	self probabilityDistributionIsValid: aProbabilityDistributionCollection.
	
	^ self new
		  initializeWithProbabilityDistribution: aProbabilityDistributionCollection
]

{ #category : #'class initialization' }
TileEffectsCreator class >> probabilityDistributionIsValid: aProbabilityDistributionCollection [

	| sum |
	sum := 0.

	aProbabilityDistributionCollection do: [ :effectProbability |
		sum := sum + effectProbability probability ].
	sum = 100 ifFalse: [
		Error signal:
			'Total efffect probabilities cannot be diferent from 100%' ]
]

{ #category : #comparing }
TileEffectsCreator >> determineRangeRandom [

	^ (probabilityManager elementAtRandom: probabilityEffects) new
		  generateParameters: self
]

{ #category : #comparing }
TileEffectsCreator >> generateHyperJumpParameters: anEffect [

	anEffect
		initializeWithParsecArray: hyperJumpArray
		andLengthInTiles: tiles
		andLengthInParsecs: parsecs
]

{ #category : #generating }
TileEffectsCreator >> generateLoadedBoardWithAmountOfTiles: anAmountOfTiles withAmountOfParsecs: anAmountOfParsecs withWormHolePair: aWormHolePair withHyperJumpArray: aHyperJumpArray withAmountOfLaps: anAmountOfLaps withCardProbabilities: aCardProbability [

	| tileEffectArray tileNumber |
	self wormHolePairIsValid: aWormHolePair with: anAmountOfTiles.

	tileEffectArray := OrderedCollection new.
	tileNumber := 0.
	tiles := anAmountOfTiles.
	parsecs := anAmountOfParsecs.
	hyperJumpArray := aHyperJumpArray.

	1 to: tiles do: [ :i |
		| anEffect |
		tileNumber := tileNumber + 1 > 100
			              ifTrue: [ 1 ]
			              ifFalse: [ tileNumber + 1 ].

		anEffect := (probabilityEffects detect: [ :aProbabilityEffect |
			             aProbabilityEffect rangeIncludes: tileNumber ])
			            associatedObject.

		tileEffectArray add: (anEffect new generateParameters: self) ].

	tileEffectArray at: 1 put: NullEffect new.

	tileEffectArray at: aWormHolePair first put: (WormholeEffect
			 fromPosition: aWormHolePair first
			 toPosition: aWormHolePair last).

	tileEffectArray at: aWormHolePair last put: (WormholeEffect
			 fromPosition: aWormHolePair last
			 toPosition: aWormHolePair first).

	^ Board
		  withTileEffectCollection: tileEffectArray
		  withLengthInUnits: (Parsec withNominalValue: anAmountOfParsecs)
		  withAmountOfLaps: anAmountOfLaps
]

{ #category : #comparing }
TileEffectsCreator >> generateMoonWalkParameters: anEffect [

	anEffect initializeWithMoonwalkDistance:
		(tiles) atRandom
]

{ #category : #generating }
TileEffectsCreator >> generateRandomBoardWithAmountOfTiles: anAmountOfTiles withAmountOfParsecs: anAmountOfParsecs withWormHolePair: aWormHolePair withHyperJumpArray: aHyperJumpArray withAmountOfLaps: anAmountOfLaps [

	| tileEffectArray |
	self wormHolePairIsValid: aWormHolePair with: anAmountOfTiles.


	tileEffectArray := OrderedCollection new.
	tiles := anAmountOfTiles.
	parsecs := anAmountOfParsecs.
	hyperJumpArray := aHyperJumpArray.

	1 to: tiles do: [ :i |
	tileEffectArray add: self determineRangeRandom ].

	tileEffectArray at: 1 put: NullEffect new.

	tileEffectArray at: aWormHolePair first put: (WormholeEffect
			 fromPosition: aWormHolePair first
			 toPosition: aWormHolePair last).

	tileEffectArray at: aWormHolePair last put: (WormholeEffect
			 fromPosition: aWormHolePair last
			 toPosition: aWormHolePair first).

	^ Board
		  withTileEffectCollection: tileEffectArray
		  withLengthInUnits: (Parsec withNominalValue: anAmountOfParsecs)
		  withAmountOfLaps: anAmountOfLaps
]

{ #category : #initialization }
TileEffectsCreator >> initializeWithProbabilityDistribution: aProbabilityDistributionCollection [

	probabilityManager := ProbabilityManager new.

	probabilityEffects := probabilityManager
		                      transformIntoProbabilityRanges:
		                      aProbabilityDistributionCollection
]

{ #category : #'argument validation' }
TileEffectsCreator >> wormHolePairIsValid: aWormHolePair with: aNumberOfTiles [

	(aWormHolePair allSatisfy: [ :i |
		 i <= aNumberOfTiles and: i strictlyPositive ]) ifFalse: [
		Error signal: 'Wormhole tiles are out of bounds' ].
	(aWormHolePair anySatisfy: [ :i | i = 1 ]) ifTrue: [
		Error signal: 'Wormhole cannot be created in first tile of board' ].
	aWormHolePair first = aWormHolePair last ifTrue: [
		Error signal: 'Wormhole tiles cannot be in the same position' ]
]
