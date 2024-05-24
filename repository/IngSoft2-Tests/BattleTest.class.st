Class {
	#name : #BattleTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BattleTest >> testShipDoesNotBattleAgainstItself [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie|
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection
		                    with: (SequenceDie withSequence: #(10 10 4 5)).
	
	
	aGame := Game
		         withBoard:
		         (Board
			          withTiles: 16
			          withWormHolePositions: aWormHoleTilePair)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	
	self assert: ((aGame allShipAmountOfShields) at: 1) equals: 3.
]

{ #category : #tests }
BattleTest >> testShipsCannotBattleInTheFirstTileOfABoard [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 16 16 4 5 )).


	aGame := Game
		         withBoard:
		         (Board
			          withTiles: 16
			          withWormHolePositions: aWormHoleTilePair)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withAmountOfLaps: 3.

	aGame playTurn.
	aGame playTurn.

	self assert: (aGame allShipAmountOfShields) equals: #( 3 3 ) asOrderedCollection .
]

{ #category : #tests }
BattleTest >> testWhenShipInAGameLandsInATileWithAnotherShipThenTheyBattle [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie|
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection
		                    with: (SequenceDie withSequence: #(10 10 4 5)).
	
	
	aGame := Game
		         withBoard:
		         (Board
			          withTiles: 16
			          withWormHolePositions: aWormHoleTilePair)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	
	self assert: ((aGame allShipAmountOfShields) at: 2) equals: 2.
]

{ #category : #tests }
BattleTest >> testWhenShipLosesABattleThenGoBackToFirstTile [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie|
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection
		                    with: (SequenceDie withSequence: #(10 10 4 5)).
	
	
	aGame := Game
		         withBoard:
		         (Board
			          withTiles: 16
			          withWormHolePositions: aWormHoleTilePair)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	
	self assert: (((aGame allShipPositions) at: 2) first) equals: 1.
]
