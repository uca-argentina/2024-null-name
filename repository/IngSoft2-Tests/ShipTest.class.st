Class {
	#name : #ShipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ShipTest >> testIfShipIsInitializedWithaNameItWillHaveThatName [

| aShip |
aShip := Ship createWithName: 'Juan'.

self assert: (aShip hasName: 'Juan')
]

{ #category : #tests }
ShipTest >> testIfShipMovesIntoPositionBelowOneThenShipPositionIsOne [

| aShip aBoard |
aBoard:= Board withTiles: 3.
aShip := Ship createWithName: 'Juan'.
aShip moveTiles: -1.

self deny: aShip givePosition equals: -1
]

{ #category : #tests }
ShipTest >> testWhenCreatedShipIsInFirstPosition [
    | aShip |
    aShip := Ship createWithName: 'Juan'.
    self assert: (aShip givePosition) equals: 1.
]

{ #category : #tests }
ShipTest >> testWhenShipMovesCurrentPositionChanges [
    | aShip aBoard |
    aBoard := Board withTiles: 5.
    aShip := Ship createWithName: 'Juan'.
    aShip moveTiles: 3.
    self assert: (aShip givePosition) equals: 4.
]
