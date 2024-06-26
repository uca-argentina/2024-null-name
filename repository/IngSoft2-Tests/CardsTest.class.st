Class {
	#name : #CardsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardsTest >> testACardCanBePlayedDuringAGame [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray|
	aTileArray := OrderedCollection new.
	2 timesRepeat: [ aTileArray add: NullEffect new ].
	
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
	
	
	self assert: (aGame playCard: NullCard  by: 'Juan' toTarget: 'all') equals: 'A NullCard has been played'.
	

	
	
		
		
	
]

{ #category : #tests }
CardsTest >> testAShipCannotBeHiredByMoreThanOneShip [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities aCardHandler |
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

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: MercenaryCard
			                                  withProbability: 100).

	aCardHandler := CardHandler withCardProbabilities:
		                collectionOfCardProbabilities.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardHandler: aCardHandler.

	aGame playTurn.
	aGame playCard: MercenaryCard by: 'Jose' toTarget: 'Juan'.
	aGame playTurn.

	self
		assert: (aGame playCard: MercenaryCard by: 'Pedro' toTarget: 'Juan')
		equals: 'Targeted ship is already a mercenary in another coalition'.
	self assert: (aGame shipCards: 'Pedro') size equals: 2
]

{ #category : #tests }
CardsTest >> testAnPermanentCardCanOnlyBePlayedDuringAShipsTurnInAGame [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray aCardHandler collectionOfCardProbabilities |
	aTileArray := OrderedCollection new.
	2 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 10.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 10).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: AccelerationCard
			                                  withProbability: 100).

	aCardHandler := CardHandler withCardProbabilities:
		                collectionOfCardProbabilities.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardHandler: aCardHandler.

	self
		assert:
		(aGame playCard: AccelerationCard by: 'Jose' toTarget: 'all')
		equals: 'Ship cannot throw this card as its not his turn'
]

{ #category : #tests }
CardsTest >> testCannotPlayACardThatDoesNotBelongToAShip [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray|
	aTileArray := OrderedCollection new.
	2 timesRepeat: [ aTileArray add: NullEffect new ].
	
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
	
	self assert: (aGame playCard: AccelerationCard by: 'Jose' toTarget: 'all') equals: 'Ship does not have that card'.
	

	
	
		
		
	
]

{ #category : #tests }
CardsTest >> testWhenACancelationCardIsPlayedDeactivateTargetedCard [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities aCardHandler |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].


	aTileArray at: 6 put: (CardGeneratorEffect withProbabilities:
			 (OrderedCollection with: (ProbabilityAssociation
					   associate: CancellationCard
					   withProbability: 100))).

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 4 )).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: AccelerationCard
			                                  withProbability: 100).

	aCardHandler := CardHandler withCardProbabilities:
		                collectionOfCardProbabilities.



	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardHandler: aCardHandler.

	aGame playTurn.
	aGame playCard: AccelerationCard by: 'Jose' toTarget:  'all'.
	aGame playCard: CancellationCard by: 'Juan' toTarget: (AccelerationCard withHolder: 'Jose').
	aGame playTurn.
	
	self assert: (aGame allShipsPosition at: 'Jose') first equals: 5
]

{ #category : #tests }
CardsTest >> testWhenACancelationCardIsPlayedItCannotTargetANonexistentCard [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities aCardHandler |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].


	aTileArray at: 6 put: (CardGeneratorEffect withProbabilities:
			 (OrderedCollection with: (ProbabilityAssociation
					   associate: CancellationCard
					   withProbability: 100))).

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 4 )).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: AccelerationCard
			                                  withProbability: 100).

	aCardHandler := CardHandler withCardProbabilities:
		                collectionOfCardProbabilities.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardHandler: aCardHandler.

	aGame playTurn.
	aGame playCard: AccelerationCard by: 'Jose' toTarget:  'all'.
	aGame playCard: CancellationCard by: 'Juan' toTarget: (AccelerationCard withHolder: 'Jose').
	aGame playTurn.
	
	self assert: (aGame allShipsPosition at: 'Jose') first equals: 5
]

{ #category : #tests }
CardsTest >> testWhenApplingRepeatCardLastEffectIsAppliedToTheTargetedShip [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities aCardHandler |
	aTileArray := OrderedCollection new.
	15 timesRepeat: [ aTileArray add: NullEffect new ].
	
	aTileArray at: 10 put: BlackHoleEffect new.
	
	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 9 4 )).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: RepeatCard
			                                  withProbability: 100).

	aCardHandler := CardHandler withCardProbabilities:
		                collectionOfCardProbabilities.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardHandler: aCardHandler.

	aGame playTurn.
	aGame playCard: RepeatCard by: 'Jose' toTarget: 'Juan'.
	
	self assert: (aGame allShipsPosition at: 'Juan') equals: #(2 1) asOrderedCollection 
]

{ #category : #tests }
CardsTest >> testWhenApplingRepeatCardOnlyEffectsTargetedToOneShipCanBeRepeated [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities aCardHandler |
	aTileArray := OrderedCollection new.
	15 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray at: 10 put: AtomicBombEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 9 4 )).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: RepeatCard
			                                  withProbability: 100).

	aCardHandler := CardHandler withCardProbabilities:
		                collectionOfCardProbabilities.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardHandler: aCardHandler.

	aGame playTurn.

	self
		assert: (aGame playCard: RepeatCard by: 'Jose' toTarget: 'Juan')
		equals:
		'AtomicBombEffect is last effect, and doesnt target a single ship'.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 1 1 ) asOrderedCollection.
	self assert: (aGame allShipAmountOfShields at: 'Juan') equals: 2
]

{ #category : #tests }
CardsTest >> testWhenApplyingRedoCardLastCardIsPlayedAgain [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities aCardHandler |
	aTileArray := OrderedCollection new.
	15 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray
		at: 6
		put:
			(CardGeneratorEffect withProbabilities: (OrderedCollection with:
					  (ProbabilityAssociation
						   associate: SpeedCard
						   withProbability: 100))).

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.

	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 1)).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: RedoCard
			                                  withProbability: 100).

	aCardHandler := CardHandler withCardProbabilities:
		                collectionOfCardProbabilities.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardHandler: aCardHandler.

	aGame playTurn. 
	aGame playTurn.
	aGame playCard: SpeedCard by: 'Juan' toTarget: 'Juan'. 
	aGame playTurn.
	aGame playCard: RedoCard by: 'Jose' toTarget: 'Jose'. 
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 4 1 ) asOrderedCollection
]

{ #category : #tests }
CardsTest >> testWhenApplyingRedoCardMultipleTimesApplyLastNonRedoCard [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities aCardHandler |
	aTileArray := OrderedCollection new.
	15 timesRepeat: [ aTileArray add: NullEffect new ].

	aTileArray
		at: 6
		put:
			(CardGeneratorEffect withProbabilities: (OrderedCollection with:
					  (ProbabilityAssociation
						   associate: SpeedCard
						   withProbability: 100))).

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.

	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 1)).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: RedoCard
			                                  withProbability: 100).

	aCardHandler := CardHandler withCardProbabilities:
		                collectionOfCardProbabilities.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardHandler: aCardHandler.

	aGame playTurn. 
	aGame playTurn.
	aGame playCard: SpeedCard by: 'Juan' toTarget: 'Juan'. 
	aGame playCard: RedoCard by: 'Juan' toTarget: 'Juan'.
	aGame playTurn.
	aGame playCard: RedoCard by: 'Jose' toTarget: 'Jose'. 
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 4 1 ) asOrderedCollection
]

{ #category : #tests }
CardsTest >> testWhenApplyingRepeatCardShipDoesNotMoveOutOfBounds [
	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities aCardHandler |
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

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: RepeatCard
			                                  withProbability: 100).

	aCardHandler := CardHandler withCardProbabilities:
		                collectionOfCardProbabilities.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardHandler: aCardHandler.

	aGame playTurn.
	aGame playCard: RepeatCard by: 'Jose' toTarget: 'Juan'.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 1 1 ) asOrderedCollection.
]

{ #category : #tests }
CardsTest >> testWhenGameIsStartedShipsHave2Cards [

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

	self assert: (aGame shipCards: 'Juan') size equals: 2
]

{ #category : #tests }
CardsTest >> testWhenMercenaryCardIsCancelledShipsCanBattleAgain [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities aCardHandler |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].


	aTileArray at: 6 put: (CardGeneratorEffect withProbabilities:
			 (OrderedCollection with: (ProbabilityAssociation
					   associate: CancellationCard
					   withProbability: 100))).

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 )).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: MercenaryCard
			                                  withProbability: 100).

	aCardHandler := CardHandler withCardProbabilities:
		                collectionOfCardProbabilities.



	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardHandler: aCardHandler.

	aGame playTurn.
	aGame playCard: MercenaryCard by: 'Jose' toTarget: 'Juan'.
	aGame playCard: CancellationCard by: 'Juan' toTarget: (MercenaryCard withHolder: 'Jose').
	aGame playTurn.
	
	self assert: (aGame allShipAmountOfShields at: 'Juan') equals: 3.
	self assert: (aGame allShipAmountOfShields at: 'Jose') equals: 2.
	
]

{ #category : #tests }
CardsTest >> testWhenMercenaryCardIsPlayedAlliedShipsDontBattle [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities aCardHandler |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 )).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: MercenaryCard
			                                  withProbability: 100).

	aCardHandler := CardHandler withCardProbabilities:
		                collectionOfCardProbabilities.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardHandler: aCardHandler.

	aGame playTurn.
	aGame playCard: MercenaryCard by: 'Jose' toTarget: 'Juan'.
	aGame playTurn.
	
	self assert: (aGame allShipAmountOfShields at: 'Juan') equals: 3.
	self assert: (aGame allShipAmountOfShields at: 'Jose') equals: 3.
]

{ #category : #tests }
CardsTest >> testWhenOneAccelerationCardIsPlayedShipsMoveOneExtraTile [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities aCardHandler |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 4 )).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: AccelerationCard
			                                  withProbability: 100).

	aCardHandler := CardHandler withCardProbabilities:
		                collectionOfCardProbabilities.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardHandler: aCardHandler.

	aGame playCard: AccelerationCard by: 'Juan' toTarget:  'all'.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame allShipsPosition at: 'Juan') first equals: 7.
	self assert: (aGame allShipsPosition at: 'Jose') first equals: 6
]

{ #category : #tests }
CardsTest >> testWhenOneSpeedCardIsPlayedTargetedShipMoveOneExtraTile [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities aCardHandler |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 5 4 )).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: SpeedCard
			                                  withProbability: 100).

	aCardHandler := CardHandler withCardProbabilities:
		                collectionOfCardProbabilities.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardHandler: aCardHandler.

	aGame playCard: SpeedCard by: 'Juan' toTarget: 'Juan'.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame allShipsPosition at: 'Juan') first equals: 7.
	self assert: (aGame allShipsPosition at: 'Jose') first equals: 5
]

{ #category : #tests }
CardsTest >> testWhenPlayingACardShipCardsDeckSizeChanges [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray |
	aTileArray := OrderedCollection new.
	2 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 10).

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playCard: NullCard by: 'Juan'  toTarget:  'all'.

	self assert: (aGame shipCards: 'Juan') size equals: 1.
	self assert: (aGame shipCards: 'Jose') size equals: 2
]

{ #category : #tests }
CardsTest >> testWhenShipWithMercenariesBattleAllOfThenThrowTheDice [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities aCardHandler |
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

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: MercenaryCard
			                                  withProbability: 100).

	aCardHandler := CardHandler withCardProbabilities:
		                collectionOfCardProbabilities.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardHandler: aCardHandler.

	aGame playTurn.
	aGame playCard: MercenaryCard by: 'Jose' toTarget: 'Juan'.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame allShipAmountOfShields at: 'Pedro') equals: 2
]
