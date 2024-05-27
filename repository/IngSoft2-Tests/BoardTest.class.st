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
		should: [ SetBoard withTiles: numTiles withAmountOfLaps:1 ]
		raise: Error
		withMessage: 'Board tiles must be greater than 0'
]

{ #category : #tests }
BoardTest >> testBoardHasANumberOfParsecs [

	|aBoard|
	
	aBoard := Board  withLengthInTileAndParsec: #(4 2)  withWormHolePositions: #(2 3) withAmountOfLaps: 1 withParsecArray: #(2 1 3 4) .

	self assert: aBoard numOfParsecs equals: 2
]

{ #category : #tests }
BoardTest >> testBoardHasANumberOfTiles [

	| numTiles aBoard |
	numTiles := 3.
	aBoard := SetBoard withTiles: numTiles withAmountOfLaps:1.

	self assert: aBoard numbOfTiles equals: 3
]

{ #category : #tests }
BoardTest >> testSpecialTilesCannotBeCreatedIfPositionsExceedBoardSize [

	| aWormholePositons |
	aWormholePositons := #( 2 6 ).

	self
		should: [
			Board
				withLengthInTileAndParsec: #(3 3)
				withWormHolePositions: aWormholePositons
				withAmountOfLaps: 3
				withParsecArray: #(2 1 3 1) ]
		raise: Error
		withMessage: 'Wormhole tiles are out of bounds'
]

{ #category : #tests }
BoardTest >> testWhenBoardIsCreatedTheAmountOfEffectsFollowTheCorrectDistribution [

	| aBoard aPairOfLengths aWormHoleTilePair aNumberOfLaps |
	aWormHoleTilePair := #( 2 4 ).
	aNumberOfLaps := 1.
	aPairOfLengths := #( 102 10 ).

	aBoard := LoadedBoard
		          withLengthInTileAndParsec: aPairOfLengths
		          withWormHolePositions: aWormHoleTilePair
		          withAmountOfLaps: aNumberOfLaps
		          withParsecArray: #( 1 3 5 1 ) asOrderedCollection.


	self assert: (aBoard numberBoxEffect at: NullEffect) equals: 40.
	self assert: (aBoard numberBoxEffect at: BlackHoleEffect) equals: 20.
	self
		assert: (aBoard numberBoxEffect at: HyperSpaceJumpEffect)
		equals: 20.
	self assert: (aBoard numberBoxEffect at: MoonWalkEffect) equals: 10.
	self assert: (aBoard numberBoxEffect at: HyperJumpEffect) equals: 8.
	self assert: (aBoard numberBoxEffect at: AtomicBombEffect) equals: 2.
	self assert: (aBoard numberBoxEffect at: WormholeEffect) equals: 2
]
