Class {
	#name : #EffectsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectsTest >> testWhenApplyingBlackHoleEffectShipMoves4SpacesBack [

	| aBoard aShip aDictionaryOfEffects |
	
	aDictionaryOfEffects:= Dictionary new
	at: 8 put: BlackHoleEffect; yourself .
	
	aBoard := SetBoard withTiles: 10 withWormHolePositions: #( 2 5 ) withEffectsInPosition: aDictionaryOfEffects.
	aShip := Ship createWithName: 'Juan'.
	aShip moveTiles: 7.
	aBoard applyTileEffectOn: aShip.


	self assert: aShip position equals: 4
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
