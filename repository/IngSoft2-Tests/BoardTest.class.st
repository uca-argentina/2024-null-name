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
	aBoard := SetBoard withTiles: numTiles withAmountOfLaps:1.

	self assert: aBoard numbOfTiles equals: 3
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

{ #category : #tests }
BoardTest >> testWhenBoardIsCreatedTheAmountOfEffectsFollowTheCorrectDistribution [

	| aBoard aNumberOfTiles aWormHoleTilePair aNumberOfParsecs aNumberOfLaps |
	aNumberOfTiles := 102.
	aWormHoleTilePair := #( 2 4 ).
	aNumberOfParsecs := 10.
	aNumberOfLaps := 1.

	aBoard := LoadedBoard
		          withTiles: aNumberOfTiles
		          withWormHolePositions: aWormHoleTilePair
		          withParsecs: aNumberOfParsecs
		          withAmountOfLaps: aNumberOfLaps.

	self assert: ((aBoard numberBoxEffect) at: NullEffect  ) equals: 40.
	self assert: ((aBoard numberBoxEffect) at: BlackHoleEffect  ) equals: 20.
	self assert: (aBoard numberBoxEffect at: HyperSpaceJumpEffect) equals: 20.
	self assert: ((aBoard numberBoxEffect) at: MoonWalkEffect ) equals: 10.
	self assert: ((aBoard numberBoxEffect) at: HyperJumpEffect ) equals: 8.
	self assert: ((aBoard numberBoxEffect) at: AtomicBombEffect ) equals: 2.
	self assert: ((aBoard numberBoxEffect) at: WormholeEffect ) equals: 2.
	
]
