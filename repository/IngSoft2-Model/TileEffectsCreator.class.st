"
A Tile effect generator for Board initialization
"
Class {
	#name : #TileEffectsCreator,
	#superclass : #Object,
	#instVars : [
		'wormHolePair',
		'probabilityEffects',
		'boardLengths'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
TileEffectsCreator class >> createWithBoardLength: aBoardLenght withWormHolePositions: aWormHolePair withParsecArray: aParsecArray withProbabilityDistribution: aProbabilityDistributionCollection [

	self numberOfTileIsValid: aBoardLenght first.
	self wormHolePairIsValid: aWormHolePair with: aBoardLenght first.
	
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
TileEffectsCreator >> determineRange [

	| aRandomNumber |
	
	aRandomNumber := ((0 to: 100) atRandom) asInteger .

	^ (probabilityEffects detect: [ :aProbabilityEffect |
		  aProbabilityEffect rangeIncludes: aRandomNumber]) effect 
]

{ #category : #comparing }
TileEffectsCreator >> generateEffectArray [

	| tileEffectArray |
	tileEffectArray := OrderedCollection new.

	1 to: (boardLengths at: 'Tiles') do: [ :i |
	tileEffectArray add: self determineRange ].

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

	| moonWalkEffectGenerator hyperJumpEffectGenerator |
	boardLengths := Dictionary newFrom: {
			                ('Tiles' -> aBoardLength first).
			                ('Parsecs' -> aBoardLength last) }.
	
	moonWalkEffectGenerator := [
	                           MoonWalkEffect withMoonwalkDistance:
		                           (boardLengths at: 'Tiles') atRandom ].

	hyperJumpEffectGenerator := [
	                            HyperJumpEffect
		                            withParsecArray: aParsecArray
		                            andBoardLengths: boardLengths ].
	wormHolePair := aWormHolePair.

	probabilityEffects := self transformIntoProbabilityRanges: aProbabilityDistributionCollection
]

{ #category : #comparing }
TileEffectsCreator >> transformIntoProbabilityRanges: aProbabilityDistributionCollection [

	| acc |
	acc := 0.

	aProbabilityDistributionCollection do: [ :effectProbability |
		effectProbability setRange: acc.
		acc := acc + effectProbability probability + 1 ].
	^ aProbabilityDistributionCollection
	
	"
		| range |
		range := OrderedCollection
			         with: acc
			         with: acc + effectProbability probability.
		dic at: range put: effectProbability effect."
	"^ dic"
]
