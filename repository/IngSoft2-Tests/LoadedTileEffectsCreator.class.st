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

	| tileEffectArray probabilityEffects |
	probabilityEffects := Dictionary newFrom: {
			                      (#( 0 40 ) -> NullEffect new).
			                      (#( 41 60 ) -> BlackHoleEffect new).
			                      (#( 61 80 ) -> HyperSpaceJumpEffect new).
			                      (#( 81 90 ) -> [
			                       MoonWalkEffect withMoonwalkDistance:
				                       (self generateMoonWalkParameters:
					                        aPairOfLengths first) ]).
			                      (#( 91 98 ) -> (HyperJumpEffect
				                        withParsecArray: aParsecArray
				                        andBoardLengths:
				                        (self
					                         generateHyperJumpParameters:
					                         aPairOfLengths
					                         and: aParsecArray))).
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

{ #category : #generators }
LoadedTileEffectsCreator >> generateHyperJumpParameters: aPairOfLenghts and: aParsecArray [

	^ Dictionary newFrom: {
			  ('Tiles' -> aPairOfLenghts first).
			  ('Parsecs' -> aPairOfLenghts last) }
]

{ #category : #generators }
LoadedTileEffectsCreator >> generateMoonWalkParameters: aBoardLength [

	^ aBoardLength atRandom
]
