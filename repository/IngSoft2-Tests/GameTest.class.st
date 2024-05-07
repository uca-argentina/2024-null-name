Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameTest >> should: anErrorBlock raise: exceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: exceptionClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
GameTest >> testGameCanTellHowManyShipsArePlaying [

	| aGame aBoard aNumberOfShips aShipCollection |
	aBoard := Board withTiles: 5.
	aNumberOfShips := 6.
	aShipCollection:= Set new.
	1 to: aNumberOfShips do: [ :iter | aShipCollection add: Ship create].
	aGame:= Game withBoard: aBoard  withShips: aShipCollection .
	self assert: (aGame amountOfShips) equals: 6.
	
	
]

{ #category : #tests }
GameTest >> testGameCannotBeInitializedWithoutABoard [

	| aBoard aShip |
	aShip:= Ship create.
	self
		should: [ Game withBoard: aBoard withShips: aShip. ]
		raise: Error
		withMessage: 'Game cannot be started without a board'
]

{ #category : #tests }
GameTest >> testGameCannotBeInitializedWithoutAtLeastOneShip [

	| aBoard aShip |
	aBoard := Board withTiles: 5.
	self
		should: [ Game withBoard: aBoard withShips: aShip. ]
		raise: Error
		withMessage: 'Game cannot be started without at least one ship.'
]

{ #category : #tests }
GameTest >> testGameKnownsOwnBoard [

	| aGame aBoard aShip |
	aBoard := Board withTiles: 1.
	aShip:= Ship create.
	aGame := Game withBoard: aBoard withShips: aShip.
	self assert: (aGame board) equals: aBoard
]

{ #category : #tests }
GameTest >> testGameKnowsOwnShips [

	| aGame aBoard aShip |
	aBoard := Board withTiles: 1.
	aShip:= Ship create.
	aGame := Game withBoard: aBoard withShips: aShip.

	self assert: (aGame ships) equals: aShip
]

{ #category : #tests }
GameTest >> testIfGameIsFinishedRerurnTrue [

	| aGame aBoard aShip |
	aBoard := Board withTiles: 1.
	aShip:= Ship create.
	aGame := Game withBoard: aBoard withShips: aShip.
	aGame endGame.

	self deny: aGame isOngoing
]

{ #category : #tests }
GameTest >> testIfGameIsNotFinishedRerurnFalse [

	| aGame aBoard aShip |
	aBoard := Board withTiles: 1.
	aShip:= Ship create.
	aGame := Game withBoard: aBoard withShips: aShip.

	self assert: aGame isOngoing
]
