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
		should: [
			SetBoard
				withLengthInTileAndParsec: #( 0 0 )
				withWormHolePositions: #( 0 0 )
				withAmountOfLaps: 1 ]
		raise: Error
		withMessage: 'Board tiles must be greater than 0'
]

{ #category : #tests }
BoardTest >> testBoardHasANumberOfParsecs [

	| aBoard |
	aBoard := Board
		          withLengthInTileAndParsec: #( 4 2 )
		          withWormHolePositions: #( 2 3 )
		          withAmountOfLaps: 1
		          withParsecArray: #( 2 1 3 4 ).

	self assert: aBoard numOfParsecs equals: 2
]

{ #category : #tests }
BoardTest >> testBoardHasANumberOfTiles [

	| aBoard |
	aBoard := SetBoard
		          withLengthInTileAndParsec: #( 3 3 )
		          withWormHolePositions: #( 2 3 )
		          withAmountOfLaps: 1.

	self assert: aBoard numbOfTiles equals: 3
]

{ #category : #tests }
BoardTest >> testBoardMustHaveAtLeast1Lap [

	| aWormHolePair |
	aWormHolePair := #( 3 4 ).

	self
		should: [
			Board
				withLengthInTileAndParsec: #( 4 4 )
				withWormHolePositions: aWormHolePair
				withAmountOfLaps: 0
				withParsecArray: #( 2 1 3 1 ) ]
		raise: Error
		withMessage: 'Cannot play with less than 1 lap'
]

{ #category : #tests }
BoardTest >> testSpecialTilesCannotBeCreatedIfPositionsExceedBoardSize [

	| aWormHolePair |
	aWormHolePair := #( 2 6 ).

	self
		should: [
			Board
				withLengthInTileAndParsec: #( 3 3 )
				withWormHolePositions: aWormHolePair
				withAmountOfLaps: 3
				withParsecArray: #( 2 1 3 1 ) ]
		raise: Error
		withMessage: 'Wormhole tiles are out of bounds'
]

{ #category : #tests }
BoardTest >> testWhenBoardIsCreatedTheAmountOfEffectsFollowTheCorrectDistribution [

	| aBoard aPairOfLengths aWormHolePair |
	aWormHolePair := #( 2 4 ).
	aPairOfLengths := #( 102 10 ).

	aBoard := LoadedBoard
		          withLengthInTileAndParsec: aPairOfLengths
		          withWormHolePositions: aWormHolePair
		          withAmountOfLaps: 1
		          withParsecArray: #( 1 3 5 1 ).

	self assert: (aBoard allTileEffectsAmount at: NullEffect) equals: 40.

	self
		assert: (aBoard allTileEffectsAmount at: BlackHoleEffect)
		equals: 20.
	self
		assert: (aBoard allTileEffectsAmount at: HyperSpaceJumpEffect)
		equals: 20.
	self
		assert: (aBoard allTileEffectsAmount at: MoonWalkEffect)
		equals: 10.
	self
		assert: (aBoard allTileEffectsAmount at: HyperJumpEffect)
		equals: 8.
	self
		assert: (aBoard allTileEffectsAmount at: AtomicBombEffect)
		equals: 2.
	self
		assert: (aBoard allTileEffectsAmount at: WormholeEffect)
		equals: 2
]

{ #category : #tests }
BoardTest >> testWormHoleEffectCannotBeCreatedInFirstTileOfBoard [

	| aWormHolePair |
	aWormHolePair := #( 1 3 ).

	self
		should: [
			Board
				withLengthInTileAndParsec: #( 3 3 )
				withWormHolePositions: aWormHolePair
				withAmountOfLaps: 3
				withParsecArray: #( 2 1 3 1 ) ]
		raise: Error
		withMessage: 'Wormhole cannot be created in first tile of board'
]

{ #category : #tests }
BoardTest >> testWormHoleTilePairsCannotOverlap [

	| aWormHolePair |
	aWormHolePair := #( 3 3 ).

	self
		should: [
			Board
				withLengthInTileAndParsec: #( 3 3 )
				withWormHolePositions: aWormHolePair
				withAmountOfLaps: 3
				withParsecArray: #( 2 1 3 1 ) ]
		raise: Error
		withMessage: 'Wormhole tiles cannot be in the same position'
]
