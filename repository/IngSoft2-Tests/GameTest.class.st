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
GameTest >> testAGameTurnCanBeSkipped [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 5).
	
	
	aGame := Game
		         withBoard:
		         (Board
			          withTiles: 16
			          withWormHolePositions: aWormHoleTilePair)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		withAmountOfLaps: 3.
	
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
		         withBoard: (SimpleBoard withTiles: 16)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).
	aGame playTurn.

	self assert: ((aGame allShipPositions at: 1) at: 1) equals: 13
]

{ #category : #tests }
GameTest >> testGameCanTellAllShipPositions [

	| aGame aCollectionOfNames aCollectionOfNamesAndPositions aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with: (SequenceDie withSequence: #(9 10 9)).


	aGame := Game
		         withBoard: (SimpleBoard withTiles: 30)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).
	aCollectionOfNamesAndPositions := OrderedCollection new
		                                  add: (OrderedCollection new
				                                   add: 19;
				                                   add: 1;
				                                   add: 'Juan';
				                                   yourself);
		                                  add: (OrderedCollection new
				                                   add: 11;
				                                   add: 1;
				                                   add: 'Jose';
				                                   yourself);
		                                  yourself.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: aGame allShipPositions
		equals: aCollectionOfNamesAndPositions
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
GameTest >> testGameCannotBeInitializedWithoutAnyShipNames [

	| aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection new.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 9).
	self
		should: [
			Game
				withBoard: (SimpleBoard withTiles: 20)
				withShipNames: aCollectionOfNames
				withDice: (Dice with: aCollectionOfDie) ]
		raise: Error
		withMessage: 'Game cannot be created without any Ship names'
]

{ #category : #tests }
GameTest >> testGameDoesNotAllowRepeatedShipNames [

	| aGame aBoard aCollectionOfNames aCollectionOfDie |
	aBoard := SimpleBoard withTiles: 5.
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
	self assert: aGame allShipPositions size equals: 3
]

{ #category : #tests }
GameTest >> testGameKnowTheWinnerShip [

	| aGame aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.

	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 9)
		                    with: (LoadedDie of: 3).

	aGame := Game
		         withBoard: (SimpleBoard withTiles: 17)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: aGame winnerName equals: 'Juan'
]

{ #category : #tests }
GameTest >> testIfGameIsFinishedThenIsFinishedIsTrue [

	| aGame aBoard aCollectionOfNames aCollectionOfDie |
	aBoard := SimpleBoard withTiles: 8.
	aCollectionOfNames := OrderedCollection with: 'Juan'.

	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 9).

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).
	aGame playTurn.

	self assert: aGame isFinished
]

{ #category : #tests }
GameTest >> testIfGameIsNotFinishedThenIsFinishedIsFalse [

	| aGame aBoard aCollectionOfNames aCollectionOfDie|
	aBoard := SimpleBoard withTiles: 10.
	aCollectionOfNames := OrderedCollection with: 'Juan'.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 9).


	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	self deny: aGame isFinished
]

{ #category : #tests }
GameTest >> testIfGameIsOngoingThereIsNoWinner [

	| aGame aCollectionOfNames aCollectionOfDie|
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.

	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 9)
		                    with: (LoadedDie of: 3).

	aGame := Game
		         withBoard: (SimpleBoard withTiles: 17)
		         withShipNames: aCollectionOfNames
		         withDice:
		         (Dice with: aCollectionOfDie).

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
		         withBoard: (SimpleBoard withTiles: 17)
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

	| aGame aCollectionOfNames aCollectionOfDie aCollectionOfNamesAndPositions |
	aCollectionOfNames := OrderedCollection with: 'Juan'.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 10).
	aCollectionOfNamesAndPositions := OrderedCollection new
		                                  add: (OrderedCollection new
				                                   add: 1;
				                                   add: 2;
				                                   add: 'Juan';
				                                   yourself);
		                                  yourself.

	aGame := Game
		         withBoard: (SimpleBoard withTiles: 10)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withAmountOfLaps: 3.

	aGame playTurn.

	self
		assert: aGame allShipPositions
		equals: aCollectionOfNamesAndPositions
]

{ #category : #tests }
GameTest >> testWhenFinishedTheEndingPositionOfTheWinnerEqualsTheSizeOfTheBoard [

	| aGame aCollectionOfNames aCollectionOfDie|
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	
	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 9)
		                    with: (LoadedDie of: 3).
	
	aGame := Game
		         withBoard: (SimpleBoard withTiles: 27)
		         withShipNames: aCollectionOfNames
		         withDice:
		         (Dice  with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.


	self assert: ((aGame allShipPositions at: 1) at: 1) equals: 27
]

{ #category : #tests }
GameTest >> testWhenOneShipReachesTheEndGameIsFinished [

	| aGame aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan'.
	
	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 9).
	
	aGame := Game
		         withBoard: (SimpleBoard withTiles: 16)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).
	aGame playTurn.
	aGame playTurn.
	self assert: aGame isFinished
]

{ #category : #tests }
GameTest >> testWhenShipInAGameLandsInWormholeEffectTileTheCorrespondingEffectIsApplied [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie|
	aCollectionOfNames := OrderedCollection with: 'Juan'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 9).
	
	
	aGame := Game
		         withBoard:
		         (Board
			          withTiles: 16
			          withWormHolePositions: aWormHoleTilePair)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.

	self assert: ((aGame allShipPositions at: 1) at: 1) equals: 15
]

{ #category : #tests }
GameTest >> testWhenTurnIsSkippedThenShipRestoresAllShields [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 5).


	aGame := Game
		         withBoard:
		         (Board
			          withTiles: 16
			          withWormHolePositions: aWormHoleTilePair)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withAmountOfLaps: 1.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: aGame allShipAmountOfShields last equals: 2.
	aGame skipTurn.
	self assert: aGame allShipAmountOfShields last equals: 3
]
