"
A Loaded tile effect generator for loaded board for testing 
"
Class {
	#name : #LoadedTileEffectsCreator,
	#superclass : #Object,
	#instVars : [
		'tileNumber'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'creating collection' }
LoadedTileEffectsCreator >> createWithWormHolePositions: aWormHolePair withBoardLenghts: aPairOfLengths withParsecArrry: aParsecArray [

	| tileEffectArray probabilityEffects moonWalkEffectGenerator hyperJumpEffectGenerator lengthsDic |
	lengthsDic := Dictionary newFrom: {
			              ('Tiles' -> aPairOfLengths first).
			              ('Parsecs' -> aPairOfLengths last) }.

	moonWalkEffectGenerator := [
	                           MoonWalkEffect withMoonwalkDistance:
		                           (lengthsDic at: 'Tiles') atRandom ].

	hyperJumpEffectGenerator := HyperJumpEffect
		                            withParsecArray: aParsecArray
		                            andBoardLengths: lengthsDic.

	probabilityEffects := Dictionary newFrom: {
			                      (#( 0 40 ) -> NullEffect new).
			                      (#( 41 60 ) -> BlackHoleEffect new).
			                      (#( 61 80 ) -> HyperSpaceJumpEffect new).
			                      (#( 81 90 ) -> moonWalkEffectGenerator).
			                      (#( 91 98 ) -> hyperJumpEffectGenerator).
			                      (#( 99 100 ) -> AtomicBombEffect new) }.

	tileNumber := 0.
	tileEffectArray := OrderedCollection new.

	1 to: aPairOfLengths first do: [ :i |
		tileEffectArray add:
			(probabilityEffects at:
				 (self determineRange: probabilityEffects keys)) value ].

	tileEffectArray at: 1 put: NullEffect new.

	tileEffectArray at: aWormHolePair first put: (WormholeEffect
			 fromPosition: aWormHolePair first
			 toPosition: aWormHolePair last).

	tileEffectArray at: aWormHolePair last put: (WormholeEffect
			 fromPosition: aWormHolePair last
			 toPosition: aWormHolePair first).

	^ tileEffectArray
]

{ #category : #comparing }
LoadedTileEffectsCreator >> determineRange: aRangeOfKeys [

	tileNumber := tileNumber + 1 > 100
		              ifTrue: [ 1 ]
		              ifFalse: [ tileNumber + 1 ].

	^ aRangeOfKeys detect: [ :aRange |
		  tileNumber between: aRange first and: aRange last ]
]
