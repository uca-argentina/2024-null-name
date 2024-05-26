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

	tileNumber := (tileNumber + 1 )> 100 ifTrue: [ 1 ] ifFalse:[tileNumber+1] .
	
	^ aRangeOfKeys detect: [ :aRange |
		  tileNumber between: aRange first and: aRange last ]
]

{ #category : #generators }
LoadedTileEffectsCreator >> generateHyperJumpParameters: aPairOfLenghts [

	| aRandomNumberGenerator aParsecCollection |
	aRandomNumberGenerator := Random new.

	"aParsecCollection := OrderedCollection new."
	
	aParsecCollection :=  #(2 3 1 4 1) asOrderedCollection.
	
	"1 to: (aRandomNumberGenerator nextBetween: 1 and: 5) do: [
		aParsecCollection add:
			((aRandomNumberGenerator nextBetween: 1 and: aPairOfLenghts last) asInteger)  ]."
	
	^ OrderedCollection with: aParsecCollection with: aPairOfLenghts
]

{ #category : #generators }
LoadedTileEffectsCreator >> generateMoonWalkParameters: aBoardLength [
	| aRandomNumberGenerator |
	aRandomNumberGenerator := Random new.

	^ aRandomNumberGenerator nextBetween: 0 and: aBoardLength.
]
