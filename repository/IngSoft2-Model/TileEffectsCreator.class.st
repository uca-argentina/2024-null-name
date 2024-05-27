"
A Tile effect generator for Board initialization
"
Class {
	#name : #TileEffectsCreator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'creating collection' }
TileEffectsCreator >> createWithWormHolePositions: aWormHolePair withBoardLenghts: aPairOfLengths withParsecArrry: aParsecArray [

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
TileEffectsCreator >> determineRange: aRangeOfKeys [

	| aRandomNumber |
	
	aRandomNumber := ((0 to: 100) atRandom) asInteger .

	^ aRangeOfKeys detect: [ :aRange |
		  aRandomNumber between: aRange first and: aRange last ]
]

{ #category : #generators }
TileEffectsCreator >> generateHyperJumpParameters: aPairOfLenghts  and: aParsecArray [

	^ Dictionary newFrom: {
			  ('parsecArray' -> aParsecArray).
			  ('Tiles' -> aPairOfLenghts first).
			  ('Parsecs' -> aPairOfLenghts last) }
]

{ #category : #generators }
TileEffectsCreator >> generateMoonWalkParameters: aBoardLength [

	^ aBoardLength atRandom
]
