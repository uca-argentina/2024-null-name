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

	| aBoard |
	aBoard isNil.
	self
		should: [ Game withBoard: aBoard ]
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
GameTest >> testIfGameIsFinishedRerurnTrue [

	| aGame aBoard |
	aBoard := Board withTiles: 1.
	aGame := Game withBoard:aBoard.
	aGame endGame.

	self deny: aGame isOngoing
]

{ #category : #tests }
GameTest >> testIfGameIsNotFinishedRerurnFalse [

	| aGame aBoard |
	aBoard := Board withTiles: 1.
	aGame := Game withBoard:aBoard.

	self assert: aGame isOngoing
]
