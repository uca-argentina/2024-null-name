"
A Tile effect generator for Board initialization
"
Class {
	#name : #TileEffectsCreator,
	#superclass : #Object,
	#instVars : [
		'wormHolePair',
		'probabilityEffects',
		'boardLengths',
		'parsecArray'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
TileEffectsCreator class >> createWithBoardLength: aBoardLenght withWormHolePositions: aWormHolePair withParsecArray: aParsecArray withProbabilityDistribution: aProbabilityDistributionCollection [

	self numberOfTileIsValid: aBoardLenght first.
	self wormHolePairIsValid: aWormHolePair with: aBoardLenght first.
	self probabilityDistributionIsValid: aProbabilityDistributionCollection.
	
	^ self new
		  initializeWithLengths: aBoardLenght
		  withWormHolePositions: aWormHolePair
		  withParsecArray: aParsecArray asOrderedCollection
		  withProbabilityDistribution: aProbabilityDistributionCollection
]

{ #category : #'class initialization' }
TileEffectsCreator class >> numberOfTileIsValid: aNumberOfTiles [

	aNumberOfTiles strictlyPositive ifFalse: [
		Error signal: 'Board tiles must be greater than 0' ]
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

{ #category : #'class initialization' }
TileEffectsCreator class >> wormHolePairIsValid: aWormHolePair with: aNumberOfTiles [

	(aWormHolePair allSatisfy: [ :i |
		 i <= aNumberOfTiles and: i strictlyPositive ]) ifFalse: [
		Error signal: 'Wormhole tiles are out of bounds' ].
	(aWormHolePair anySatisfy: [ :i | i = 1 ]) ifTrue: [
		Error signal: 'Wormhole cannot be created in first tile of board' ].
	aWormHolePair first = aWormHolePair last ifTrue: [
		Error signal: 'Wormhole tiles cannot be in the same position' ]
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

	anEffect initializeWithParsecs: parsecArray andBoardLengths: boardLengths
]

{ #category : #'creating collection' }
TileEffectsCreator >> generateLoadedEffectArray [

	| tileEffectArray tileNumber |
	tileEffectArray := OrderedCollection new.
	tileNumber := 0.

	1 to: (boardLengths at: 'Tiles') do: [ :i |
		| anEffect |
		tileNumber := tileNumber + 1 > 100
			              ifTrue: [ 1 ]
			              ifFalse: [ tileNumber + 1 ].

		anEffect := (probabilityEffects detect: [ :aProbabilityEffect |
			             aProbabilityEffect rangeIncludes: tileNumber ]) effect.

		tileEffectArray add: (anEffect new generateParameters: self) ].

	tileEffectArray at: 1 put: NullEffect new.

	tileEffectArray at: wormHolePair first put: (WormholeEffect
			 fromPosition: wormHolePair first
			 toPosition: wormHolePair last).

	tileEffectArray at: wormHolePair last put: (WormholeEffect
			 fromPosition: wormHolePair last
			 toPosition: wormHolePair first).

	^ tileEffectArray
]

{ #category : #comparing }
TileEffectsCreator >> generateMoonWalkParameters: anEffect [

	anEffect initializeWithMoonwalkDistance:
		(boardLengths at: 'Tiles') atRandom
]

{ #category : #'creating collection' }
TileEffectsCreator >> generateRandomEffectArray [

	| tileEffectArray |
	tileEffectArray := OrderedCollection new.

	1 to: (boardLengths at: 'Tiles') do: [ :i |
	tileEffectArray add: self determineRangeRandom ].

	tileEffectArray at: 1 put: NullEffect new.

	tileEffectArray at: wormHolePair first put: (WormholeEffect
			 fromPosition: wormHolePair first
			 toPosition: wormHolePair last).

	tileEffectArray at: wormHolePair last put: (WormholeEffect
			 fromPosition: wormHolePair last
			 toPosition: wormHolePair first).

	^ tileEffectArray

]

{ #category : #'creating collection' }
TileEffectsCreator >> initializeWithLengths: aBoardLength withWormHolePositions: aWormHolePair withParsecArray: aParsecArray withProbabilityDistribution: aProbabilityDistributionCollection [

	boardLengths := Dictionary newFrom: {
			                ('Tiles' -> aBoardLength first).
			                ('Parsecs' -> aBoardLength last) }.

	wormHolePair := aWormHolePair.
	parsecArray := aParsecArray.
	probabilityEffects := self transformIntoProbabilityRanges:
		                      aProbabilityDistributionCollection
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
