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
GameTest >> testGameCannotBeInitializedWithoutABoard [

	| aGame aBoard aShip |
	aBoard isNil.
	aShip:= Ship inside: aBoard.
	self
		should: [ Game withBoard: aBoard withShips: aShip. ]
		raise: Error
		withMessage: 'Game cannot be started without a board'
]

{ #category : #tests }
GameTest >> testGameKnownsOwnBoard [

	| aBoard aGame |
	aBoard := Board withTiles: 1.
	aGame:= Game withBoard: aBoard.
	self assert: (aGame board) equals: aBoard
]

{ #category : #tests }
GameTest >> testGameKnowsOwnShips [

	| aGame aBoard aShip |
	aBoard := Board withTiles: 1.
	aShip:= Ship inside: aBoard.
	aGame := Game withBoard: aBoard withShips: aShip.

	self assert: (aGame ships) equals: aShip
]

{ #category : #tests }
GameTest >> testIfGameIsFinishedRerurnTrue [

	| aGame aBoard aShip |
	aBoard := Board withTiles: 1.
	aShip:= Ship inside: aBoard.
	aGame := Game withBoard: aBoard withShips: aShip.
	aGame endGame.

	self deny: aGame isOngoing
]

{ #category : #tests }
GameTest >> testIfGameIsNotFinishedRerurnFalse [

	| aGame aBoard aShip |
	aBoard := Board withTiles: 1.
	aShip:= Ship inside: aBoard.
	aGame := Game withBoard: aBoard withShips: aShip.

	self assert: aGame isOngoing
]
