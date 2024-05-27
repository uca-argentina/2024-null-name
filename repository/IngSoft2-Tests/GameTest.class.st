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
GameTest >> testAGameCanShowTheCurrentRanking [

	| aGame aCollectionOfNames aCollectionOfDie aShipNameAndPosition |
	aCollectionOfNames := OrderedCollection
		                      with: 'Juan'
		                      with: 'Pedro'
		                      with: 'Fran'.

	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 3 1 8 )).

	aGame := Game
		         withBoard: (SetBoard withTiles: 15 withAmountOfLaps:3)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	aShipNameAndPosition := Dictionary new.
	aShipNameAndPosition at: 'Juan' put: #( 10 1 ) asOrderedCollection.
	aShipNameAndPosition at: 'Pedro' put: #( 2 2 ) asOrderedCollection.
	aShipNameAndPosition at: 'Fran' put: #( 3 1 ) asOrderedCollection.

	self
		assert: (aGame shipRankings at: 1)
		equals: (aShipNameAndPosition associationAt: 'Pedro').
	self
		assert: (aGame shipRankings at: 2)
		equals: (aShipNameAndPosition associationAt: 'Juan').
	self
		assert: (aGame shipRankings at: 3)
		equals: (aShipNameAndPosition associationAt: 'Fran')
]

{ #category : #tests }
GameTest >> testAGameTurnCanBeSkipped [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 5).


	aGame := Game
		         withBoard: (Board
				          withTiles: 16
				          withWormHolePositions: aWormHoleTilePair
				          withAmountOfLaps: 3)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	self assert: aGame skipTurn equals: 'Juan skipped their turn'
]

{ #category : #tests }
GameTest >> testGameCanBePlayedWithMoreThanOneDie [

	| aGame aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan'.
	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 9)
		                    with: (LoadedDie of: 3).
	aGame := Game
		         withBoard: (SetBoard withTiles: 16 withAmountOfLaps:1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 13 1 ) asOrderedCollection
]

{ #category : #tests }
GameTest >> testGameCanTellAllShipPositions [

	| aGame aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 9 10 9 )).

	aGame := Game
		         withBoard: (SetBoard withTiles: 30 withAmountOfLaps:1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 19 1 ) asOrderedCollection.
	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 11 1 ) asOrderedCollection
]

{ #category : #tests }
GameTest >> testGameCannotBeInitializedWithoutABoard [

	| aBoard aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan'.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 9).
	
	self
		should: [
			Game
				withBoard: aBoard
				withShipNames: aCollectionOfNames
				withDice: (Dice with: aCollectionOfDie) ]
		raise: Error
		withMessage: 'Game cannot be started without a board'
]

{ #category : #tests }
GameTest >> testGameCannotBeInitializedWithoutADice [

	| aBoard aCollectionOfNames aDie |
	aCollectionOfNames := OrderedCollection with: 'Juan'.
	aBoard := SetBoard withTiles: 13 withAmountOfLaps: 1.



	self
		should: [
			Game
				withBoard: aBoard
				withShipNames: aCollectionOfNames
				withDice: aDie ]
		raise: Error
		withMessage: 'Game cannot be started without at least one die'
]

{ #category : #tests }
GameTest >> testGameCannotBeInitializedWithoutAnyShipNames [

	| aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection new.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 9).
	self
		should: [
			Game
				withBoard: (SetBoard withTiles: 20 withAmountOfLaps:1)
				withShipNames: aCollectionOfNames
				withDice: (Dice with: aCollectionOfDie) ]
		raise: Error
		withMessage: 'Game cannot be created without any Ship names'
]

{ #category : #tests }
GameTest >> testGameDoesNotAllowRepeatedShipNames [

	| aGame aBoard aCollectionOfNames aCollectionOfDie |
	aBoard := SetBoard withTiles: 5 withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection
		                      with: 'Juan'
		                      with: 'Jose'
		                      with: 'Fran'
		                      with: 'Juan'.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 9).

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).
	self assert: aGame allShipsPosition size equals: 3
]

{ #category : #tests }
GameTest >> testGameKnowTheWinnerShip [

	| aGame aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.

	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 9)
		                    with: (LoadedDie of: 3).

	aGame := Game
		         withBoard: (SetBoard withTiles: 17 withAmountOfLaps:1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: aGame winnerName equals: 'Juan'
]

{ #category : #tests }
GameTest >> testIfGameIsNotFinishedThenIsFinishedIsTrue [

	| aGame aBoard aCollectionOfNames aCollectionOfDie |
	aBoard := SetBoard withTiles: 10 withAmountOfLaps: 1.
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
GameTest >> testIfGameIsOngoingThereIsNoWinner [

	| aGame aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.

	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 9)
		                    with: (LoadedDie of: 3).

	aGame := Game
		         withBoard: (SetBoard withTiles: 17 withAmountOfLaps: 1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.

	self assert: aGame winnerName equals: 'There is no winner yet'
]

{ #category : #tests }
GameTest >> testIfThereIsAWinnerThereAreNoMoreMovements [

	| aGame aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.

	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 9)
		                    with: (LoadedDie of: 3).

	aGame := Game
		         withBoard: (SetBoard withTiles: 17 withAmountOfLaps: 1)
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
GameTest >> testWhenAShipFinishesLapThenPositionIsAdjustedAccordingly [

	| aGame aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan'.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 10).

	aGame := Game
		         withBoard: (SetBoard withTiles: 10 withAmountOfLaps: 3)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 1 2 ) asOrderedCollection
]

{ #category : #tests }
GameTest >> testWhenFinishedTheEndingPositionOfTheWinnerEqualsTheFirstTileOfBoard [

	| aGame aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.

	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 9)
		                    with: (LoadedDie of: 3).

	aGame := Game
		         withBoard: (SetBoard withTiles: 27 withAmountOfLaps: 1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.


	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 1 2 ) asOrderedCollection
]

{ #category : #tests }
GameTest >> testWhenOneShipReachesTheEndGameIsFinished [

	| aGame aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan'.

	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 9).

	aGame := Game
		         withBoard: (SetBoard withTiles: 16 withAmountOfLaps: 1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).
	aGame playTurn.
	aGame playTurn.
	self assert: aGame isFinished
]

{ #category : #tests }
GameTest >> testWhenShipHasNoShieldsLeftThenCannotPlayTurn [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence:
			                     #( 1 1 1 1 1 2 1 1 1 3 )).


	aGame := Game
		         withBoard: (SetBoard
				          withTiles: 16
				          withWormHolePositions: aWormHoleTilePair
				          withAmountOfLaps: 3)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: aGame playTurn equals: 'Pedro lost their turn'
]

{ #category : #tests }
GameTest >> testWhenShipWithNoShieldLosesTwoTurnsThenCanPlayAgain [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence:
			                     #( 1 1 1 1 1 2 1 1 1 3 )).


	aGame := Game
		         withBoard: (SetBoard
				          withTiles: 16
				          withWormHolePositions: aWormHoleTilePair
				          withAmountOfLaps: 3)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.

	aGame playTurn.
	aGame playTurn.

	aGame playTurn.
	aGame playTurn.

	aGame playTurn.
	aGame playTurn.

	aGame playTurn.
	aGame playTurn.

	aGame playTurn.

	self deny: aGame playTurn equals: 'Pedro lost their turn'
]

{ #category : #tests }
GameTest >> testWhenShipWithNoShieldsCannotSkipTurn [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence:
			                     #( 1 1 1 1 1 2 1 1 1 3 )).


	aGame := Game
		         withBoard: (SetBoard 
				          withTiles: 16
				          withWormHolePositions: aWormHoleTilePair
				          withAmountOfLaps: 3)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: aGame skipTurn equals: 'Pedro lost their turn'
]

{ #category : #tests }
GameTest >> testWhenTurnIsSkippedThenShipRestoresAllShields [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 5).

	aGame := Game
		         withBoard:
		         (SetBoard
			          withTiles: 16
			          withWormHolePositions: aWormHoleTilePair)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame allShipAmountOfShields at: 'Pedro') equals: 2.
	aGame skipTurn.
	self assert: (aGame allShipAmountOfShields at: 'Pedro') equals: 3
]
