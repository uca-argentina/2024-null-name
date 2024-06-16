Class {
	#name : #TurnPlayabilityTest,
	#superclass : #GameTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
TurnPlayabilityTest >> testAGameTurnCanBeSkipped [

	| aGame aCollectionOfNames aWormHolePair aCollectionOfDie aTileArray |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHolePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 5).
	aTileArray := OrderedCollection new.
	
	16 timesRepeat: [ aTileArray add: NullEffect new ].

	aGame := Game
		         withBoard: (Board
				          withTileEffectCollection: aTileArray
				          withLength: #( 16 16 )
				          withAmountOfLaps: 3)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	self assert: aGame skipTurn equals: 'Juan skipped their turn'
]

{ #category : #tests }
TurnPlayabilityTest >> testWhenAShipFinishesLapThenPositionIsAdjustedAccordingly [

	| aGame aCollectionOfNames aCollectionOfDie aTileArray|
	aCollectionOfNames := OrderedCollection with: 'Juan'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 10 20 )).
	
	aTileArray:= OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].
	
	aGame := Game
		         withBoard: (Board
				          withTileEffectCollection: aTileArray
				          withLength: #( 10 10 )
				          withAmountOfLaps: 5)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 1 2 ) asOrderedCollection.
	aGame playTurn.
	
	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 1 4 ) asOrderedCollection.
]

{ #category : #tests }
TurnPlayabilityTest >> testWhenFinishedTheEndingPositionOfTheWinnerEqualsTheFirstTileOfBoard [

	| aGame aCollectionOfNames aCollectionOfDie aTileArray|
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.

	aCollectionOfDie := OrderedCollection
		                    with: (LoadedDie of: 9)
		                    with: (LoadedDie of: 3).

	aTileArray:= OrderedCollection new.
	27 timesRepeat: [ aTileArray add: NullEffect new ].
	
	aGame := Game
		         withBoard: (Board
				          withTileEffectCollection: aTileArray
				          withLength: #( 27 27 )
				          withAmountOfLaps: 1)
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

	| aGame aCollectionOfNames aWormHolePair aCollectionOfDie aTileArray|
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHolePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence:
			                     #( 1 1 1 1 1 2 1 1 1 3 )).
	

	aTileArray:= OrderedCollection new.
	16 timesRepeat: [ aTileArray add: NullEffect new ].
	
	aGame := Game
		         withBoard: (Board
				          withTileEffectCollection: aTileArray
				          withLength: #( 16 16 )
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
TurnPlayabilityTest >> testWhenShipWithNoShieldLosesTwoTurnsThenCanPlayAgain [

	| aGame aCollectionOfNames aWormHolePair aCollectionOfDie aTileArray |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHolePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence:
			                     #( 1 1 1 1 1 2 1 1 1 3 )).


	aTileArray := OrderedCollection new.
	16 timesRepeat: [ aTileArray add: NullEffect new ].

	aGame := Game
		         withBoard: (Board
				          withTileEffectCollection: aTileArray
				          withLength: #( 16 16 )
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
TurnPlayabilityTest >> testWhenShipWithNoShieldsCannotSkipTurn [

	| aGame aCollectionOfNames aWormHolePair aCollectionOfDie aTileArray |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHolePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence:
			                     #( 1 1 1 1 1 2 1 1 1 3 )).


	aTileArray := OrderedCollection new.
	16 timesRepeat: [ aTileArray add: NullEffect new ].

	aGame := Game
		         withBoard: (Board
				          withTileEffectCollection: aTileArray
				          withLength: #( 16 16 )
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
TurnPlayabilityTest >> testWhenTurnIsSkippedThenShipRestoresAllShields [

	| aGame aCollectionOfNames aWormHolePair aCollectionOfDie aTileArray |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHolePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 5).

	aTileArray := OrderedCollection new.
	16 timesRepeat: [ aTileArray add: NullEffect new ].

	aGame := Game
		         withBoard: (Board
				          withTileEffectCollection: aTileArray
				          withLength: #( 16 16 )
				          withAmountOfLaps: 1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame allShipAmountOfShields at: 'Pedro') equals: 2.
	aGame skipTurn.
	self assert: (aGame allShipAmountOfShields at: 'Pedro') equals: 3
]
