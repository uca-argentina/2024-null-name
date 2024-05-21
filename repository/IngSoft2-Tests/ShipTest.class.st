Class {
	#name : #ShipTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ShipTest >> should: anErrorBlock raise: exceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: exceptionClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
ShipTest >> testIfShipIsInitializedWithaNameItWillHaveThatName [

	| aShip |
	aShip := Ship createWithName: 'Juan'.

	self assert: aShip shipName equals: 'Juan'
]

{ #category : #tests }
ShipTest >> testIfShipMovesIntoPositionBelowOneThenShipPositionIsOne [

	| aShip |
	aShip := Ship createWithName: 'Juan'.
	aShip moveTiles: -1.

	self assert: aShip position equals: 1
]

{ #category : #tests }
ShipTest >> testShipCannotBeCreatedWithNoName [

	| aName |
	aName := ''.
	self
		should: [ Ship createWithName: aName ]
		raise: Error
		withMessage: 'Ship cannot be created with no name'
]

{ #category : #tests }
ShipTest >> testWhenCreatedShipIsInFirstPosition [

	| aShip |
	aShip := Ship createWithName: 'Juan'.
	self assert: aShip position equals: 1
]

{ #category : #tests }
ShipTest >> testWhenShipMovesCurrentPositionChanges [

	| aShip |
	aShip := Ship createWithName: 'Juan'.
	aShip moveTiles: 3.
	self assert: aShip position equals: 4
]
