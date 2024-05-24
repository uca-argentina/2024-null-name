Class {
	#name : #EffectsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectsTest >> testWhenApplyingBlackHoleEffectShipMoves4SpacesBack [

	| aBoard aShip aDictionaryOfEffects |
	aDictionaryOfEffects := Dictionary new
		                        at: 8 put: (OrderedCollection with: BlackHoleEffect with: #());
		                        yourself.

	aBoard := SetBoard
		          withTiles: 10
		          withWormHolePositions: #( 2 5 )
		          withEffectsInPosition: aDictionaryOfEffects.
	aShip := Ship createWithName: 'Juan'.
	aShip moveTiles: 7.
	aBoard applyTileEffectOn: aShip.


	self assert: aShip position equals: 4
]

{ #category : #tests }
EffectsTest >> testWhenApplyingHyperJumpEffectShipMovesAVariableParsecDistance [

	| aBoard aShip aDictionaryOfEffects |
	aDictionaryOfEffects := Dictionary new
		                        at: 3 put: (OrderedCollection with: HyperJumpEffect with: (OrderedCollection with:#(2 5 3 1) with: #(10 20)));
		                        yourself.
		
	aBoard := SetBoard
		          withTiles: 20
		          withWormHolePositions: #( 2 5 )
		          withEffectsInPosition: aDictionaryOfEffects.
	aShip := Ship createWithName: 'Juan'.
	aShip moveTiles: 2.
	aBoard applyTileEffectOn: aShip.


	self assert: aShip position equals: 13
]

{ #category : #tests }
EffectsTest >> testWhenApplyingHyperSpaceJumpEffectShipLosesAShield [

	| aBoard aShip aDictionaryOfEffects |
	aDictionaryOfEffects := Dictionary new
		                        at: 4 put: (OrderedCollection with: HyperSpaceJumpEffect with: #());
		                        yourself.

	aBoard := SetBoard
		          withTiles: 10
		          withWormHolePositions: #( 2 5 )
		          withEffectsInPosition: aDictionaryOfEffects.
	aShip := Ship createWithName: 'Juan'.
	aShip moveTiles: 3.
	aBoard applyTileEffectOn: aShip.


	self assert: (aShip amountOfShieldsActive) equals: 2
]

{ #category : #tests }
EffectsTest >> testWhenApplyingHyperSpaceJumpEffectShipMoves4SpacesForward [

	| aBoard aShip aDictionaryOfEffects |
	aDictionaryOfEffects := Dictionary new
		                        at: 4 put: (OrderedCollection with: HyperSpaceJumpEffect with: #());
		                        yourself.

	aBoard := SetBoard
		          withTiles: 10
		          withWormHolePositions: #( 2 5 )
		          withEffectsInPosition: aDictionaryOfEffects.
	aShip := Ship createWithName: 'Juan'.
	aShip moveTiles: 3.
	aBoard applyTileEffectOn: aShip.


	self assert: aShip position equals: 8
]

{ #category : #tests }
EffectsTest >> testWhenApplyingWormholeEffectOnShipMoveAccordingly [

	| aBoard aShip |
	aBoard := SetBoard withTiles: 10 withWormHolePositions: #( 2 5 ).
	aShip := Ship createWithName: 'Juan'.
	aShip moveTiles: 1.
	aBoard applyTileEffectOn: aShip.


	self assert: aShip position equals: 5
]