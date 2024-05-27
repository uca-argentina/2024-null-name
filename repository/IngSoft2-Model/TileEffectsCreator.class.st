"
A Tile effect generator for Board initialization
"
Class {
	#name : #TileEffectsCreator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'creating collection' }
TileEffectsCreator >> createWithWormHolePositions: aWormHoleTilePair withBoardLenghts: aPairOfLengths withParsecArrry: aParsecArray [

	| tileEffectArray probabilityEffects |
	probabilityEffects := Dictionary newFrom: {
			                      (#( 0 40 ) -> (NullEffect createWith: '')).
			                      (#( 41 60 )
			                       -> (BlackHoleEffect createWith: '')).
			                      (#( 61 80 )
			                       -> (HyperSpaceJumpEffect createWith: '')).
			                      (#( 81 90 ) -> [
			                       MoonWalkEffect createWith:
				                       (self generateMoonWalkParameters:
					                        aPairOfLengths first) ]).
			                      (#( 91 98 ) -> (HyperJumpEffect createWith:
				                        (self generateHyperJumpParameters:
					                         aPairOfLengths and: aParsecArray))).
			                      (#( 99 100 )
			                       -> (AtomicBombEffect createWith: '')) }.

	tileEffectArray := OrderedCollection new.

	1 to: aPairOfLengths first do: [ :i |
		tileEffectArray add:
			(probabilityEffects at:
				 (self determineRange: probabilityEffects keys)) value ].

	tileEffectArray at: 1 put: (NullEffect createWith: '').

	tileEffectArray
		at: aWormHoleTilePair first
		put: (WormholeEffect createWith: aWormHoleTilePair).

	tileEffectArray
		at: aWormHoleTilePair last
		put: (WormholeEffect createWith: aWormHoleTilePair reversed).

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
