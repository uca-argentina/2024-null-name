Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameTest >> should: anErrorBlock raise: exceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: exceptionClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
GameTest >> testAGameCanShowTheCurrentRanking [

	| aGame aCollectionOfNames aCollectionOfDie aTileArray |
	aCollectionOfNames := OrderedCollection
		                      with: 'Juan'
		                      with: 'Pedro'
		                      with: 'Fran'.

	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 3 1 8 )).

	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].

	aGame := Game
		         withBoard: (Board
				          withTileEffectCollection: aTileArray
				          withLengthInUnits: (Parsec withNominalValue: 10)
				          withAmountOfLaps: 3)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame shipRankings at: 1) shipName equals: 'Pedro'.
	self assert: (aGame shipRankings at: 2) shipName equals: 'Juan'.
	self assert: (aGame shipRankings at: 3) shipName equals: 'Fran'
]

{ #category : #tests }
GameTest >> testGameCanTellAllShipPositions [

	| aGame aCollectionOfNames aCollectionOfDie aTileArray|
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 9 10 9 )).


	aTileArray := OrderedCollection new.
	30 timesRepeat: [ aTileArray add: NullEffect new ].

	aGame := Game
		         withBoard: (Board
				          withTileEffectCollection: aTileArray
				          withLengthInUnits: (Parsec withNominalValue: 10)
				          withAmountOfLaps: 1)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 19 1 ) asOrderedCollection.
	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 11 1 ) asOrderedCollection
]
