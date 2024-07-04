Class {
	#name : #CardsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardsTest >> should: anErrorBlock raise: exceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: exceptionClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
CardsTest >> testAShipCannotBeHiredByMoreThanOneShip [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	
	aCollectionOfNames := OrderedCollection
		                      with: 'Juan'
		                      with: 'Jose'
		                      with: 'Pedro'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 7 4 4 )).
	
	collectionOfCards := OrderedCollection new.
	10 timesRepeat: [ collectionOfCards add: MercenaryCard ].
	aDeck := LoadedDeck withCards: collectionOfCards.
	
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.
	
	aTarget := ShipTarget withObjective: 'Juan'.
	
	aGame playTurn.
	aGame playCard: MercenaryCard by: 'Jose' toTarget: aTarget .
	aGame playTurn.

	self
		assert: (aGame playCard: MercenaryCard by: 'Pedro' toTarget: aTarget)
		equals: 'Targeted ship is already a mercenary in another coalition'.
	self assert: (aGame shipCards: 'Pedro') size equals: 2
]

{ #category : #tests }
CardsTest >> testWhenACancelationCardIsPlayedDeactivateTargetedCard [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget anotherTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 4 )).

	collectionOfCards := OrderedCollection
		                     with: CancellationCard
		                     with: AccelerationCard
		                     with: CancellationCard
		                     with: AccelerationCard.

	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.

	aTarget := CardTarget withObjective:
		           (AccelerationCard withHolder: 'Jose').
		
	anotherTarget := AllTarget new.
	
	aGame playTurn.
	aGame playCard: AccelerationCard by: 'Jose' toTarget: anotherTarget.
	aGame playCard: CancellationCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.

	self assert: (aGame allShipsPosition at: 'Jose') first equals: 5
]

{ #category : #tests }
CardsTest >> testWhenACancelationCardIsPlayedItCannotTargetANonexistentCard [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget anotherTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].


	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 4 )).

	collectionOfCards := OrderedCollection
		                     with: CancellationCard
		                     with: AccelerationCard
		                     with: CancellationCard
		                     with: AccelerationCard.
	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.

	aTarget := CardTarget withObjective:
		           (AccelerationCard withHolder: 'Jose').

	anotherTarget := AllTarget new.


	aGame playTurn.
	aGame playCard: AccelerationCard by: 'Jose' toTarget: anotherTarget.
	aGame playCard: CancellationCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.

	self assert: (aGame allShipsPosition at: 'Jose') first equals: 5
]

{ #category : #tests }
CardsTest >> testWhenApplyingRedoCardLastCardIsPlayedAgain [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget anotherTarget |
	aTileArray := OrderedCollection new.
	15 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray at: 6 put: CardGeneratorEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.

	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 1 )).

	collectionOfCards := OrderedCollection new.
	4 timesRepeat: [ collectionOfCards add: RedoCard ].
	collectionOfCards add: SpeedCard.
	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.

	aTarget := ShipTarget withObjective: 'Juan'.
	anotherTarget := ShipTarget withObjective: 'Jose'.

	aGame playTurn.
	aGame playTurn.
	aGame playCard: SpeedCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.
	aGame playCard: RedoCard by: 'Jose' toTarget: anotherTarget.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 4 1 ) asOrderedCollection
]

{ #category : #tests }
CardsTest >> testWhenApplyingRedoCardMultipleTimesApplyLastNonRedoCard [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget anotherTarget |
	aTileArray := OrderedCollection new.
	15 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray at: 6 put: CardGeneratorEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.

	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 1 )).

	collectionOfCards := OrderedCollection new.
	4 timesRepeat: [ collectionOfCards add: RedoCard ].
	collectionOfCards add: SpeedCard.
	aDeck := LoadedDeck withCards: collectionOfCards.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.
	
	aTarget := ShipTarget withObjective: 'Juan'.
	anotherTarget := ShipTarget withObjective: 'Jose'.
	
	
	aGame playTurn.
	aGame playTurn.
	aGame playCard: SpeedCard by: 'Juan' toTarget: aTarget.
	aGame playCard: RedoCard by: 'Juan' toTarget: aTarget.
	aGame playTurn.
	aGame playCard: RedoCard by: 'Jose' toTarget: anotherTarget.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 4 1 ) asOrderedCollection
]

{ #category : #tests }
CardsTest >> testWhenApplyingRepeatCardShipDoesNotMoveOutOfBounds [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray at: 6 put: BlackHoleEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 )).

	collectionOfCards := OrderedCollection new.
	10 timesRepeat: [ collectionOfCards add: RepeatCard ].
	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.
	
	aTarget := ShipTarget withObjective: 'Juan'.
	
	aGame playTurn.
	aGame playCard: RepeatCard by: 'Jose' toTarget: aTarget .

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 1 1 ) asOrderedCollection
]

{ #category : #tests }
CardsTest >> testWhenMercenaryCardIsCancelledShipsCanBattleAgain [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck aTarget anotherTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].


	aTileArray at: 6 put: CardGeneratorEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 )).

	collectionOfCards := OrderedCollection new.
	4 timesRepeat: [ collectionOfCards add: MercenaryCard ].
	collectionOfCards add: CancellationCard.
	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.


	aTarget := ShipTarget withObjective: 'Juan'.
	anotherTarget := CardTarget withObjective:
		                 (MercenaryCard withHolder: 'Jose').

	aGame playTurn.
	aGame playCard: MercenaryCard by: 'Jose' toTarget: aTarget.
	aGame
		playCard: CancellationCard
		by: 'Juan'
		toTarget: (anotherTarget).
	aGame playTurn.

	self assert: (aGame allShipAmountOfShields at: 'Juan') equals: 3.
	self assert: (aGame allShipAmountOfShields at: 'Jose') equals: 2
]

{ #category : #tests }
CardsTest >> testWhenMercenaryCardIsPlayedAlliedShipsDontBattle [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray aPosition collectionOfCards aDeck aTarget |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 )).


	collectionOfCards := OrderedCollection new.
	10 timesRepeat: [ collectionOfCards add: MercenaryCard ].
	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.
	
	aTarget := ShipTarget withObjective: 'Juan'	.
	aGame playTurn.
	aGame playCard: MercenaryCard by: 'Jose' toTarget: aTarget.
	aGame playTurn.

	aPosition := #( 6 1 ) asOrderedCollection.

	self assert: (aGame allShipsPosition at: 'Juan') equals: aPosition.
	self assert: (aGame allShipsPosition at: 'Jose') equals: aPosition.

	self assert: (aGame allShipAmountOfShields at: 'Juan') equals: 3.
	self assert: (aGame allShipAmountOfShields at: 'Jose') equals: 3
]
