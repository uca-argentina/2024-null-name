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

	^ self new
		  initializeWithLengths: aBoardLenght
		  withWormHolePositions: aWormHolePair
		  withParsecArray: aParsecArray asOrderedCollection
		  withProbabilityDistribution: aProbabilityDistributionCollection
]

{ #category : #'class initialization' }
TileEffectsCreator class >> createWithWormHolePositions: aWormHolePair withBoardLenghts: aPairOfLengths withParsecArray: aParsecArray [

	^ self new
		  initializeWithWormHolePositions: aWormHolePair
		  withBoardLenghts: aPairOfLengths
		  withParsecArray: aParsecArray
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

{ #category : #'creating collection' }
TileEffectsCreator >> initializeWithWormHolePositions: aWormHolePair withBoardLenghts: aPairOfLengths withParsecArray: aParsecArray [

	| moonWalkEffectGenerator hyperJumpEffectGenerator |
	boardLengths := Dictionary newFrom: {
			                ('Tiles' -> aPairOfLengths first).
			                ('Parsecs' -> aPairOfLengths last) }.

	moonWalkEffectGenerator := [
	                           MoonWalkEffect withMoonwalkDistance:
		                           (boardLengths at: 'Tiles') atRandom ].

	hyperJumpEffectGenerator := [
	                            HyperJumpEffect
		                            withParsecArray: aParsecArray
		                            andBoardLengths: boardLengths ].
	wormHolePair := aWormHolePair.

	probabilityEffects := Dictionary newFrom: {
			                      (#( 0 40 ) -> NullEffect new).
			                      (#( 41 60 ) -> BlackHoleEffect new).
			                      (#( 61 80 ) -> HyperSpaceJumpEffect new).
			                      (#( 81 90 ) -> moonWalkEffectGenerator).
			                      (#( 91 98 ) -> hyperJumpEffectGenerator).
			                      (#( 99 100 ) -> AtomicBombEffect new) }
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
