Class {
	#name : #CardPlayabilityTest,
	#superclass : #CardsTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardPlayabilityTest >> testACardCanBePlayedDuringAGame [

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
CardPlayabilityTest >> testAnPermanentCardCanOnlyBePlayedDuringAShipsTurnInAGame [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCardProbabilities |
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
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withCardProbabilities: collectionOfCardProbabilities.

	self
		assert:
		(aGame playCard: AccelerationCard by: 'Jose' toTarget: 'all')
		equals: 'Ship cannot throw this card as its not his turn'
]

{ #category : #tests }
CardPlayabilityTest >> testCannotPlayACardThatDoesNotBelongToAShip [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray |
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

	self
		assert:
		(aGame playCard: AccelerationCard by: 'Jose' toTarget: 'all')
		equals: 'Ship does not have that card'
]

{ #category : #tests }
CardPlayabilityTest >> testWhenGameIsStartedShipsHave2Cards [

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
CardPlayabilityTest >> testWhenPlayingACardShipCardsDeckSizeChanges [

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
