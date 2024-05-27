Class {
	#name : #GameFinishTest,
	#superclass : #GameTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameFinishTest >> testGameKnowTheWinnerShip [

	| aGame aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.

	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 9)
		                    with: (LoadedDie of: 3).

	aGame := Game
		         withBoard: (SetBoard
				          withLengthInTileAndParsec: #( 17 17 )
				          withWormHolePositions: #( 2 3 )
				          withAmountOfLaps: 1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: aGame winnerName equals: 'Juan'
]

{ #category : #tests }
GameFinishTest >> testIfGameIsNotFinishedThenIsFinishedIsTrue [

	| aGame aBoard aCollectionOfNames aCollectionOfDie |
	aBoard := SetBoard
		          withLengthInTileAndParsec: #( 10 10 )
		          withWormHolePositions: #( 2 3 )
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan'.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 10).


	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.

	self assert: aGame isFinished
]

{ #category : #tests }
GameFinishTest >> testIfGameIsOngoingThereIsNoWinner [

	| aGame aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.

	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 9)
		                    with: (LoadedDie of: 3).

	aGame := Game
		         withBoard: (SetBoard
				          withLengthInTileAndParsec: #( 17 17 )
				          withWormHolePositions: #( 2 3 )
				          withAmountOfLaps: 1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.

	self assert: aGame winnerName equals: 'There is no winner yet'
]

{ #category : #tests }
GameFinishTest >> testIfThereIsAWinnerThereAreNoMoreMovements [

	| aGame aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.

	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 9)
		                    with: (LoadedDie of: 3).

	aGame := Game
		         withBoard: (SetBoard
				          withLengthInTileAndParsec: #( 17 17 )
				          withWormHolePositions: #( 2 3 )
				          withAmountOfLaps: 1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		should: [ aGame playTurn ]
		raise: Error
		withMessage: 'Game is Over you cant Keep Playing'
]

{ #category : #tests }
GameFinishTest >> testWhenOneShipReachesTheEndGameIsFinished [

	| aGame aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan'.

	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 9).

	aGame := Game
		         withBoard: (SetBoard
				          withLengthInTileAndParsec: #( 16 16 )
				          withWormHolePositions: #( 2 3 )
				          withAmountOfLaps: 1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).
	aGame playTurn.
	aGame playTurn.
	self assert: aGame isFinished
]
