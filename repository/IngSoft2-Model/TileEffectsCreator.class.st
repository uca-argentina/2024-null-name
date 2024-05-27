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

	| tileEffectArray probabilityEffects moonWalkEffectGenerator hyperJumpEffectGenerator boardLengthsDictionary |
	
	boardLengthsDictionary := Dictionary newFrom: {
			                          ('Tiles' -> aPairOfLengths first).
			                          ('Parsecs' -> aPairOfLengths last) }.

	moonWalkEffectGenerator := [
	                           MoonWalkEffect withMoonwalkDistance:
		                           (boardLengthsDictionary at: 'Tiles')
			                           atRandom ].

	hyperJumpEffectGenerator := HyperJumpEffect
		                            withParsecArray: aParsecArray
		                            andBoardLengths: boardLengthsDictionary.

	probabilityEffects := Dictionary newFrom: {
			                      (#( 0 40 ) -> NullEffect new).
			                      (#( 41 60 ) -> BlackHoleEffect new).
			                      (#( 61 80 ) -> HyperSpaceJumpEffect new).
			                      (#( 81 90 ) -> moonWalkEffectGenerator).
			                      (#( 91 98 ) -> hyperJumpEffectGenerator).
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
