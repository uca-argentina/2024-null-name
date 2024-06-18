Class {
	#name : #BattleTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BattleTest >> testBanana [

	self assert: 1 equals: 1
]

{ #category : #tests }
BattleTest >> testShipsCannotBattleInTheFirstTileOfABoard [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie aTileArray |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 16 16 4 5 )).

	aTileArray := OrderedCollection new.

	16 timesRepeat: [ aTileArray add: NullEffect new ].

	aGame := Game
		         withBoard: (Board
				          withTileEffectCollection: aTileArray
				          withLengthInParsecs: 16
				          withAmountOfLaps: 3)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.

	self assert: (aGame allShipAmountOfShields at: 'Juan') equals: 3.
	self assert: (aGame allShipAmountOfShields at: 'Pedro') equals: 3
]

{ #category : #tests }
BattleTest >> testWhenShipInAGameLandsInATileWithAnotherShipThenTheyBattle [

	| aGame aCollectionOfNames aCollectionOfDie aTileArray |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 10 10 4 5 )).


	aTileArray := OrderedCollection new.
	16 timesRepeat: [ aTileArray add: NullEffect new ].
	
	aGame := Game
		         withBoard: (Board
				          withTileEffectCollection: aTileArray
				          withLengthInParsecs: 16
				          withAmountOfLaps: 1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.

	self assert: (aGame allShipAmountOfShields at: 'Pedro') equals: 2
]

{ #category : #tests }
BattleTest >> testWhenShipLosesABattleThenGoBackToFirstTile [

	| aGame aCollectionOfNames aWormHoleTilePair aCollectionOfDie aTileArray|
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Pedro'.
	aWormHoleTilePair := #( 10 15 ).
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 10 10 4 5 )).
	
	aTileArray := OrderedCollection new.

	16 timesRepeat: [ aTileArray add: NullEffect new ].

	aGame := Game
		         withBoard: (Board
				          withTileEffectCollection: aTileArray
				          withLengthInParsecs: 16
				          withAmountOfLaps: 1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Pedro')
		equals: #( 1 1 ) asOrderedCollection
]
