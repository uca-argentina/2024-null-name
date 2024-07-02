Class {
	#name : #CardPlayabilityTest,
	#superclass : #CardsTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardPlayabilityTest >> testAnPermanentCardCanOnlyBePlayedDuringAShipsTurnInAGame [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck |
	aTileArray := OrderedCollection new.
	2 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 10.
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 10).

	collectionOfCards := OrderedCollection new.
	10 timesRepeat: [ collectionOfCards add: AccelerationCard ].
	aDeck := LoadedDeck withCards: collectionOfCards.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.

	self
		should: [
		aGame playCard: AccelerationCard by: 'Jose' toTarget: 'all' ]
		raise: CardExeption
		withMessage: 'Ship cannot throw this card as its not his turn'
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
		should: [
		aGame playCard: AccelerationCard by: 'Jose' toTarget: 'all' ]
		raise: CardExeption
		withMessage: 'Ship does not have that card'.
	
]

{ #category : #tests }
CardPlayabilityTest >> testCannotPlayACardThatHasInvalidTarget [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray collectionOfCards aDeck |
	aTileArray := OrderedCollection new.
	2 timesRepeat: [ aTileArray add: NullEffect new ].

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.

	aCollectionOfNames := OrderedCollection with: 'Jose'.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 10).

	collectionOfCards := OrderedCollection new.
	10 timesRepeat: [ collectionOfCards add: SpeedCard ].
	aDeck := LoadedDeck withCards: collectionOfCards.
	
	
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie)
		         withDeck: aDeck.

	self
		should: [ aGame playCard: SpeedCard by: 'Jose' toTarget: 'Juan' ]
		raise: CardExeption
		withMessage: 'Target is not valid'
]

{ #category : #tests }
CardPlayabilityTest >> testWhenGameIsStartedShipsHave2Cards [

	| aGame aBoard aCollectionOfNames aCollectionOfDie aTileArray aDeck collectionOfCards|
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].


	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection with: 'Juan'.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 10).
	
	collectionOfCards := OrderedCollection new.
	10 timesRepeat: [ collectionOfCards add: SpeedCard ].
	aDeck := LoadedDeck withCards: collectionOfCards.
	
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
