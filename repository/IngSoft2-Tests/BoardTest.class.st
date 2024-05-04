Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoardTest >> should: anErrorBlock raise: exceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: exceptionClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
BoardTest >> testBoardCannotBeInitializedWithLessThanOneTile [

	| numTiles |
	numTiles := 0.
	self
		should: [ Board withTiles: numTiles ]
		raise: Error
		withMessage: 'Board tiles must be greater than 0'
]

{ #category : #tests }
BoardTest >> testBoardHasANumberOfTiles [

| numTiles aBoard |
numTiles :=3.
aBoard := Board withTiles:numTiles .

self assert: aBoard numbOfTiles equals: 3
]

{ #category : #tests }
BoardTest >> testBoardInitializedWithAllTilesEmpty [

	| numTiles aBoard |
	numTiles := 4.
	aBoard := Board withTiles: numTiles.

	self assert: aBoard emptyTiles equals: 4
]
