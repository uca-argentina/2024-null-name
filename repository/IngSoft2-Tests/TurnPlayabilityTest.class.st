Class {
	#name : #TurnPlayabilityTest,
	#superclass : #GameTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
TurnPlayabilityTest >> testAGameTurnCanBeSkipped [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 5).


	aGame := Game
		         withBoard: (Board
				          withLengthInTileAndParsec: #( 16 16 )
				          withWormHolePositions: aWormHoleTilePair
				          withAmountOfLaps: 3
				          withParsecArray: #( 1 3 1 5 ))
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	self assert: aGame skipTurn equals: 'Juan skipped their turn'
]

{ #category : #tests }
TurnPlayabilityTest >> testWhenAShipFinishesLapThenPositionIsAdjustedAccordingly [

	| aGame aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan'.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 10).

	aGame := Game
		         withBoard: (SetBoard
				          withLengthInTileAndParsec: #( 10 10 )
				          withWormHolePositions: #(2 3)
				          withAmountOfLaps: 3
				          withEffectsInPosition: Dictionary new)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 1 2 ) asOrderedCollection
]

{ #category : #tests }
TurnPlayabilityTest >> testWhenFinishedTheEndingPositionOfTheWinnerEqualsTheFirstTileOfBoard [

	| aGame aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.

	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 9)
		                    with: (LoadedDie of: 3).

	aGame := Game
		         withBoard: (SetBoard
				          withLengthInTileAndParsec: #( 27 27 )
				          withWormHolePositions: #( 2 3 )
				          withAmountOfLaps: 1
				          withEffectsInPosition: Dictionary new)
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
TurnPlayabilityTest >> testWhenShipHasNoShieldsLeftThenCannotPlayTurn [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence:
			                     #( 1 1 1 1 1 2 1 1 1 3 )).


	aGame := Game
		         withBoard: (SetBoard
				          withLengthInTileAndParsec: #( 16 16 )
				          withWormHolePositions: aWormHoleTilePair
				          withAmountOfLaps: 3
				          withEffectsInPosition: Dictionary new)
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
TurnPlayabilityTest >> testWhenShipWithNoShieldLosesTwoTurnsThenCanPlayAgain [

    | aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie |
    aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
    aWormHoleTilePair := #( 10 15 ).
    aCollectionOfDie := OrderedCollection with:
                            (SequenceDie withSequence:
                                 #( 1 1 1 1 1 2 1 1 1 3 )).


    aGame := Game
                 withBoard: (SetBoard
				          withLengthInTileAndParsec: #( 16 16 )
				          withWormHolePositions: aWormHoleTilePair
				          withAmountOfLaps: 3
				          withEffectsInPosition: Dictionary new)
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
TurnPlayabilityTest >> testWhenShipWithNoShieldsCannotSkipTurn [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence:
			                     #( 1 1 1 1 1 2 1 1 1 3 )).


	aGame := Game
		         withBoard: (SetBoard
				          withLengthInTileAndParsec: #( 16 16 )
				          withWormHolePositions: aWormHoleTilePair
				          withAmountOfLaps: 3
				          withEffectsInPosition: Dictionary new)
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
TurnPlayabilityTest >> testWhenTurnIsSkippedThenShipRestoresAllShields [

    | aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie |
    aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
    aWormHoleTilePair := #( 10 15 ).
    aCollectionOfDie := OrderedCollection with: (LoadedDie of: 5).

    aGame := Game
                 withBoard:
                 (SetBoard
				          withLengthInTileAndParsec: #( 16 16 )
				          withWormHolePositions: aWormHoleTilePair
				          withAmountOfLaps: 1
				          withEffectsInPosition: Dictionary new)
                 withShipNames: aCollectionOfNames
                 withDice: (Dice with: aCollectionOfDie).

    aGame playTurn.
    aGame playTurn.
    aGame playTurn.
    self assert: (aGame allShipAmountOfShields at: 'Pedro') equals: 2.
    aGame skipTurn.
    self assert: (aGame allShipAmountOfShields at: 'Pedro') equals: 3
]
