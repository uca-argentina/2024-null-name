Class {
	#name : #ShipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ShipTest >> testIfShipGoesOverLastTileThenStop [
	| aShip aBoard |
	aBoard := Board withTiles: 6.
	aShip := Ship inside: aBoard.
	aShip moveTiles: 8.
	self assert: (aShip ownPosition) equals: 6.
]

{ #category : #tests }
ShipTest >> testWhenCreatedShipIsInABoard [
	| aShip aBoard |
	aBoard := Board withTiles: 5.
	aShip := Ship inside: aBoard.
	self deny: (aShip myBoard) equals: nil.
]

{ #category : #tests }
ShipTest >> testWhenCreatedShipIsInFirstTileOfBoard [
	| aShip aBoard |
	aBoard := Board withTiles: 5.
	aShip := Ship inside: aBoard.
	self assert: (aShip ownPosition) equals: 0.
]

{ #category : #tests }
ShipTest >> testWhenShipMovesCurrentPositionChanges [
	| aShip aBoard |
	aBoard := Board withTiles: 5.
	aShip := Ship inside: aBoard.
	aShip moveTiles: 3.
	self assert: (aShip ownPosition) equals: 3.
]
