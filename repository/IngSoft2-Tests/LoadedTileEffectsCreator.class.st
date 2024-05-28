"
A Loaded tile effect generator for loaded board for testing 
"
Class {
	#name : #LoadedTileEffectsCreator,
	#superclass : #Object,
	#instVars : [
		'tileNumber',
		'wormHolePair',
		'probabilityEffects',
		'boardLengths'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'class initialization' }
LoadedTileEffectsCreator class >> createWithWormHolePositions: aWormHolePair withBoardLenghts: aPairOfLengths withParsecArray: aParsecArray [

	^ self new
		  initializeWithWormHolePositions: aWormHolePair
		  withBoardLenghts: aPairOfLengths
		  withParsecArray: aParsecArray
]

{ #category : #comparing }
LoadedTileEffectsCreator >> determineRange: aRangeOfKeys [

	tileNumber := tileNumber + 1 > 100
		              ifTrue: [ 1 ]
		              ifFalse: [ tileNumber + 1 ].

	^ aRangeOfKeys detect: [ :aRange |
		  tileNumber between: aRange first and: aRange last ]
]

{ #category : #comparing }
LoadedTileEffectsCreator >> generateEffectArray [

	| tileEffectArray |
	tileEffectArray := OrderedCollection new.

	1 to: (boardLengths at: 'Tiles') do: [ :i |
		tileEffectArray add:
			(probabilityEffects at:
				 (self determineRange: probabilityEffects keys)) value ].

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
LoadedTileEffectsCreator >> initializeWithWormHolePositions: aWormHolePair withBoardLenghts: aPairOfLengths withParsecArray: aParsecArray [

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
			                      (#( 99 100 ) -> AtomicBombEffect new) }.

	tileNumber := 0
]
