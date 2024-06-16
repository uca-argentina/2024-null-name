"
A Tile effect generator for Board initialization
"
Class {
	#name : #TileEffectsCreator,
	#superclass : #Object,
	#instVars : [
		'probabilityEffects',
		'parsecArray',
		'tiles',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
TileEffectsCreator class >> createWithProbabilityDistribution: aProbabilityDistributionCollection [

	"self numberOfTileIsValid: aBoardLenght first.
	self wormHolePairIsValid: aWormHolePair with: aBoardLenght first."
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

	| aRandomNumber anEffect |
	aRandomNumber := (1 to: 100) atRandom asInteger.

	anEffect := ((probabilityEffects detect: [ :aProbabilityEffect |
		             aProbabilityEffect rangeIncludes: aRandomNumber ])
		            effect).

	(anEffect class new) generateParameters: self.

	^ anEffect
]

{ #category : #comparing }
TileEffectsCreator >> generateHyperJumpParameters: anEffect [

	anEffect
		initializeWithParsecArray: parsecArray
		andLengthInTiles: tiles
		andLengthInParsecs: parsecs
]

{ #category : #generating }
TileEffectsCreator >> generateLoadedBoardWithAmountOfTiles: anAmountOfTiles withAmountOfParsecs: anAmountOfParsecs withWormHolePair: aWormHolePair withParsecArray: aParsecArray withAmountOfLaps: anAmountOfLaps [

	| tileEffectArray tileNumber |
	
	self numberOfTilesIsValid: anAmountOfTiles.
	self numberOfParsecsIsValid: anAmountOfParsecs.
	self wormHolePairIsValid: aWormHolePair with: anAmountOfTiles.
	
	tileEffectArray := OrderedCollection new.
	tileNumber := 0.
	tiles := anAmountOfTiles.
	parsecs := anAmountOfParsecs.
	parsecArray := aParsecArray.

	1 to: tiles do: [ :i |
		| anEffect |
		tileNumber := tileNumber + 1 > 100
			              ifTrue: [ 1 ]
			              ifFalse: [ tileNumber + 1 ].

		anEffect := (probabilityEffects detect: [ :aProbabilityEffect |
			             aProbabilityEffect rangeIncludes: tileNumber ]) effect.

		tileEffectArray add: (anEffect new generateParameters: self) ].

	tileEffectArray at: 1 put: NullEffect new.

	tileEffectArray at: aWormHolePair first put: (WormholeEffect
			 fromPosition: aWormHolePair first
			 toPosition: aWormHolePair last).

	tileEffectArray at: aWormHolePair last put: (WormholeEffect
			 fromPosition: aWormHolePair last
			 toPosition: aWormHolePair first).

	^ Board withTileEffectCollection: tileEffectArray withLengthInParsecs: anAmountOfParsecs withAmountOfLaps: anAmountOfLaps
]

{ #category : #comparing }
TileEffectsCreator >> generateMoonWalkParameters: anEffect [

	anEffect initializeWithMoonwalkDistance:
		(tiles) atRandom
]

{ #category : #generating }
TileEffectsCreator >> generateRandomBoardWithAmountOfTiles: anAmountOfTiles withAmountOfParsecs: anAmountOfParsecs withWormHolePair: aWormHolePair withParsecArray: aParsecArray withAmountOfLaps: anAmountOfLaps [

	| tileEffectArray |
	
	self numberOfTilesIsValid: anAmountOfTiles.
	self numberOfParsecsIsValid: anAmountOfParsecs.
	self wormHolePairIsValid: aWormHolePair with: anAmountOfTiles.
	
	
	tileEffectArray := OrderedCollection new.
	tiles := anAmountOfTiles.
	parsecs := anAmountOfParsecs.
	parsecArray := aParsecArray.

	1 to: tiles do: [ :i |
	tileEffectArray add: self determineRangeRandom ].

	tileEffectArray at: 1 put: NullEffect new.

	tileEffectArray at: aWormHolePair first put: (WormholeEffect
			 fromPosition: aWormHolePair first
			 toPosition: aWormHolePair last).

	tileEffectArray at: aWormHolePair last put: (WormholeEffect
			 fromPosition: aWormHolePair last
			 toPosition: aWormHolePair first).

	^ Board withTileEffectCollection: tileEffectArray withLengthInParsecs: anAmountOfParsecs withAmountOfLaps: anAmountOfLaps
]

{ #category : #initialization }
TileEffectsCreator >> initializeWithProbabilityDistribution: aProbabilityDistributionCollection [

	probabilityEffects := self transformIntoProbabilityRanges:
		                      aProbabilityDistributionCollection
]

{ #category : #'argument validation' }
TileEffectsCreator >> numberOfParsecsIsValid: aNumberOfParsecs [

	aNumberOfParsecs strictlyPositive ifFalse: [
		Error signal: 'Board size in parsecs must be greater than 0' ]
]

{ #category : #'argument validation' }
TileEffectsCreator >> numberOfTilesIsValid: aNumberOfTiles [

	aNumberOfTiles strictlyPositive ifFalse: [
		Error signal: 'Board tiles must be greater than 0' ]
]

{ #category : #comparing }
TileEffectsCreator >> transformIntoProbabilityRanges: aProbabilityDistributionCollection [

	| acc |
	acc := 0.

	aProbabilityDistributionCollection do: [ :effectProbability |
		effectProbability setRange: acc.
		acc := acc + effectProbability probability].
	^ aProbabilityDistributionCollection
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
