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
LoadedTileEffectsCreator >> createWithWormHolePositions: aWormHoleTilePair withBoardLenghts: aPairOfLengths [

	| tileEffectArray probabilityEffects |
	probabilityEffects := Dictionary newFrom: {
			                      (#( 0 40 ) -> (NullEffect createWith: '')).
			                      (#( 41 60 )
			                       -> (BlackHoleEffect createWith: '')).
			                      (#( 61 80 )
			                       -> (HyperSpaceJumpEffect createWith: '')).
			                      (#( 81 90 ) -> (MoonWalkEffect createWith:
				                        (self generateMoonWalkParameters:
					                         aPairOfLengths first))).
			                      (#( 91 98 ) -> (HyperJumpEffect createWith:
				                        (self generateHyperJumpParameters:
					                         aPairOfLengths))).
			                      (#( 99 100 )
			                       -> (AtomicBombEffect createWith: '')) }.

	tileEffectArray := OrderedCollection new.

	tileNumber := 0.

	1 to: aPairOfLengths first do: [ :i |
		tileEffectArray add:
			(probabilityEffects at:
				 (self determineRange: probabilityEffects keys)) ].

	tileEffectArray at: 1 put: (NullEffect createWith: '').

	tileEffectArray
		at: aPairOfLengths first
		put: (NullEffect createWith: '').


	tileEffectArray
		at: aWormHoleTilePair first
		put: (WormholeEffect createWith: aWormHoleTilePair).

	tileEffectArray
		at: aWormHoleTilePair last
		put: (WormholeEffect createWith: aWormHoleTilePair reversed).



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
LoadedTileEffectsCreator >> generateHyperJumpParameters: aPairOfLenghts [

	| aParsecCollection |
	aParsecCollection := OrderedCollection new.

	1 to: (5 atRandom) do: [:i|
		aParsecCollection add:
			((1 to: aPairOfLenghts last) atRandom asInteger) ].

	^ OrderedCollection with: aParsecCollection with: aPairOfLenghts
]

{ #category : #generators }
LoadedTileEffectsCreator >> generateMoonWalkParameters: aBoardLength [

	^ 1 to: aBoardLength atRandom
]
