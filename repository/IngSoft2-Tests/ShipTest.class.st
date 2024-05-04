Class {
	#name : #ShipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ShipTest >> testWhenCreatedShipIsInFirstTileOfBoard [
	| aShip aBoard |
	aBoard := Board withTiles: 5.
	aShip := Ship inside: aBoard.
	self assert: (aShip ownPosition) equals: 0.
]
