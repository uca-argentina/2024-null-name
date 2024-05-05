Class {
	#name : #ShipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ShipTest >> testWhenCreatedShipIsInFirstTileOfBoard [
	| aShip aBoard |
	aBoard := Board withTiles: 5.
	aShip := Ship create.
	self assert: (aShip givePosition) equals: 0.
]

{ #category : #tests }
ShipTest >> testWhenShipMovesCurrentPositionChanges [
	| aShip aBoard |
	aBoard := Board withTiles: 5.
	aShip := Ship create.
	aShip moveTiles: 3.
	self assert: (aShip givePosition) equals: 3.
]
