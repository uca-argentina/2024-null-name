Class {
	#name : #WormholeTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
WormholeTest >> testWhenApplyingWormholeEffectOnShipMoveAccordingly [
	| aTile aTile2 aShip |
	aShip:= Ship createWithName: 'Juan'.
	aTile:= Tile inPosition: 2 withWormholeTo: 5.
	aTile2:= Tile inPosition: 5 withWormholeTo: 2.
	aShip moveTiles: 1.
	aTile applyEffectOn: aShip.
	self assert:  aShip givePosition equals: 5. 
]
