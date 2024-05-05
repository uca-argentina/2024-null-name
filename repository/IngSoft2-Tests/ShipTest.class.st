Class {
	#name : #ShipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ShipTest >> testIfShipMovesIntoPositionBelowZeroThenShipPositionIsZero [

| aShip |
aShip := Ship create.
aShip moveTiles: -1.

self deny: aShip givePosition equals: -1
]

{ #category : #tests }
ShipTest >> testWhenCreatedShipIsInFirstPosition [
	| aShip |
	aShip := Ship create.
	self assert: (aShip givePosition) equals: 1.
]

{ #category : #tests }
ShipTest >> testWhenShipMovesCurrentPositionChanges [
	| aShip aBoard |
	aBoard := Board withTiles: 5.
	aShip := Ship create.
	aShip moveTiles: 3.
	self assert: (aShip givePosition) equals: 4.
]
