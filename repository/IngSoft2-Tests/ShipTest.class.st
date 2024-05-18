Class {
	#name : #ShipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ShipTest >> testIfShipIsInitializedWithaNameItWillHaveThatName [

| aShip |
aShip := Ship createWithName: 'Juan'.

self assert: (aShip shipName) equals: 'Juan'
]

{ #category : #tests }
ShipTest >> testIfShipMovesIntoPositionBelowOneThenShipPositionIsOne [

| aShip |
aShip := Ship createWithName: 'Juan'.
aShip moveTiles: -1.

self deny: aShip position equals: -1
]

{ #category : #tests }
ShipTest >> testWhenCreatedShipIsInFirstPosition [
    | aShip |
    aShip := Ship createWithName: 'Juan'.
    self assert: (aShip position) equals: 1.
]

{ #category : #tests }
ShipTest >> testWhenShipMovesCurrentPositionChanges [
    | aShip |
    aShip := Ship createWithName: 'Juan'.
    aShip moveTiles: 3.
    self assert: (aShip position) equals: 4.
]
