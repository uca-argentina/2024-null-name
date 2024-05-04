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
