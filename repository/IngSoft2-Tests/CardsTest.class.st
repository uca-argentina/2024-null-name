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
	
	aGame playCard: Card by: 'Juan'.
	
	
	self assert: (aGame playCard: Card by: 'Juan') equals: 'A Card has been played'.
	

	
	
		
		
	
]

{ #category : #tests }
CardsTest >> testAnInstantCardCanBePlayedDuringAGame [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray aCardHandler collectionOfCardProbabilities |
	aTileArray := OrderedCollection new.
	2 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan'.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 10).

	collectionOfCardProbabilities := OrderedCollection with:
		                                 (ProbabilityAssociation
			                                  associate: InstantCard
			                                  withProbability: 100).

	aCardHandler := CardHandler withCardProbabilities:
		                collectionOfCardProbabilities.
	
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
					withCardHandler: aCardHandler.

	self
		assert: (aGame playCard: InstantCard by: 'Juan')
		equals: 'A Card has been played'
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
	
	aGame playCard: Card by: 'Juan'.
	
	self assert: (aGame playCard: InstantCard by: 'Juan') equals: 'Ship does not have that card'.
	

	
	
		
		
	
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
