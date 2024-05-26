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
		should: [ SimpleBoard withTiles: numTiles ]
		raise: Error
		withMessage: 'Board tiles must be greater than 0'
]

{ #category : #tests }
BoardTest >> testBoardHasANumberOfParsecs [

	| numTiles aBoard numParsecs|
	numTiles := 4.
	numParsecs := 2.
	
	aBoard := Board  withTiles: numTiles withWormHolePositions: #(2 3) withParsecs: numParsecs.

	self assert: aBoard numOfParsecs equals: 2
]

{ #category : #tests }
BoardTest >> testBoardHasANumberOfTiles [

	| numTiles aBoard |
	numTiles := 3.
	aBoard := SimpleBoard withTiles: numTiles.

	self assert: aBoard numbOfTiles equals: 3
]

{ #category : #tests }
BoardTest >> testIfShipMovesOverBoardBoundsThenSnapBackToLastTile [

	| aBoard aShip |
	aBoard := SimpleBoard withTiles: 6.
	aShip := Ship createWithName: 'Juan'.
	aShip moveTiles: 7.
	aBoard snapToLastTile: aShip.
	self assert: aShip position equals: 6
]

{ #category : #tests }
BoardTest >> testSpecialTilesCannotBeCreatedIfPositionsExceedBoardSize [

	| aWormholePositons |
	aWormholePositons := #( 2 6 ).

	self
		should: [
		Board withTiles: 3 withWormHolePositions: aWormholePositons ]
		raise: Error
		withMessage: 'Wormhole tiles are out of bounds'
]
