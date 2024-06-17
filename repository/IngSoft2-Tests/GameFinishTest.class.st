Class {
	#name : #GameFinishTest,
	#superclass : #GameTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameFinishTest >> testGameKnowTheWinnerShip [

	| aGame aCollectionOfNames aCollectionOfDie aTileArray|
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.

	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 9)
		                    with: (LoadedDie of: 3).

	aTileArray := OrderedCollection new.
	17 timesRepeat: [ aTileArray add: NullEffect new ].

	aGame := Game
		         withBoard: (Board
				          withTileEffectCollection: aTileArray
				          withLengthInUnits: (Parsec withNominalValue: 10)
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

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].



	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
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

	| aGame aCollectionOfNames aCollectionOfDie aTileArray |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.

	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 9)
		                    with: (LoadedDie of: 3).

	aTileArray := OrderedCollection new.
	17 timesRepeat: [ aTileArray add: NullEffect new ].	

	aGame := Game
		         withBoard: (	Board
				          withTileEffectCollection: aTileArray
				          withLengthInUnits: (Parsec withNominalValue: 10)
				          withAmountOfLaps: 1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.

	self assert: aGame winnerName equals: 'There is no winner yet'
]

{ #category : #tests }
GameFinishTest >> testIfThereIsAWinnerThereAreNoMoreMovements [

	| aGame aCollectionOfNames aCollectionOfDie aTileArray|
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.

	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 9)
		                    with: (LoadedDie of: 3).

	aTileArray := OrderedCollection new.
	17 timesRepeat: [ aTileArray add: NullEffect new ].

	aGame := Game
		         withBoard: (Board
				          withTileEffectCollection: aTileArray
				          withLengthInUnits: (Parsec withNominalValue: 10)
				          withAmountOfLaps: 1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	
	self
		should: [ aGame playTurn ]
		raise: Error
		withMessage: 'Game is Over you cant Keep Playing'.
		
]

{ #category : #tests }
GameFinishTest >> testWhenOneShipReachesTheEndGameIsFinished [

	| aGame aCollectionOfNames aCollectionOfDie aTileArray |
	aCollectionOfNames := OrderedCollection with: 'Juan'.

	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 9).
	
	aTileArray := OrderedCollection new.
	16 timesRepeat: [ aTileArray add: NullEffect new ].
	
	aGame := Game
		         withBoard: (Board
				          withTileEffectCollection: aTileArray
				          withLengthInUnits: (Parsec withNominalValue: 10)
				          withAmountOfLaps: 1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).
	aGame playTurn.
	aGame playTurn.
	self assert: aGame isFinished
]
