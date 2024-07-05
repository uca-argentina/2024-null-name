Class {
	#name : #CardsEffectTest,
	#superclass : #CardsTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardsEffectTest >> testWhenApplingRepeatCardLastEffectIsAppliedToTheTargetedShip [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities |
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

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardProbabilities: collectionOfCardProbabilities.

	aGame playTurn.
	aGame playCard: RepeatCard by: 'Jose' toTarget: 'Juan'.
	
	self assert: (aGame allShipsPosition at: 'Juan') equals: #(2 1) asOrderedCollection 
]

{ #category : #tests }
CardsEffectTest >> testWhenOneAccelerationCardIsPlayedShipsMoveOneExtraTile [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities |
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

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardProbabilities: collectionOfCardProbabilities.

	aGame playCard: AccelerationCard by: 'Juan' toTarget:  'all'.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame allShipsPosition at: 'Juan') first equals: 7.
	self assert: (aGame allShipsPosition at: 'Jose') first equals: 6
]

{ #category : #tests }
CardsEffectTest >> testWhenOneSpeedCardIsPlayedTargetedShipMoveOneExtraTile [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities |
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

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardProbabilities: collectionOfCardProbabilities.

	aGame playCard: SpeedCard by: 'Juan' toTarget: 'Juan'.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame allShipsPosition at: 'Juan') first equals: 7.
	self assert: (aGame allShipsPosition at: 'Jose') first equals: 5
]

{ #category : #tests }
CardsEffectTest >> testWhenShipWithMercenariesBattleAllOfThenThrowTheDice [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities |
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

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardProbabilities: collectionOfCardProbabilities.

	aGame playTurn.
	aGame playCard: MercenaryCard by: 'Jose' toTarget: 'Juan'.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame allShipAmountOfShields at: 'Pedro') equals: 2
]
