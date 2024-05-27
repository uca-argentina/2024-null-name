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

	| aGame aCollectionOfNames aCollectionOfDie aShipNameAndPosition |
	aCollectionOfNames := OrderedCollection
		                      with: 'Juan'
		                      with: 'Pedro'
		                      with: 'Fran'.

	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 3 1 8 )).

	aGame := Game
		         withBoard: (SetBoard withTiles: 15 withAmountOfLaps:3)
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	aShipNameAndPosition := Dictionary new.
	aShipNameAndPosition at: 'Juan' put: #( 10 1 ) asOrderedCollection.
	aShipNameAndPosition at: 'Pedro' put: #( 2 2 ) asOrderedCollection.
	aShipNameAndPosition at: 'Fran' put: #( 3 1 ) asOrderedCollection.

	self
		assert: (aGame shipRankings at: 1)
		equals: (aShipNameAndPosition associationAt: 'Pedro').
	self
		assert: (aGame shipRankings at: 2)
		equals: (aShipNameAndPosition associationAt: 'Juan').
	self
		assert: (aGame shipRankings at: 3)
		equals: (aShipNameAndPosition associationAt: 'Fran')
]

{ #category : #tests }
GameTest >> testGameCanTellAllShipPositions [

	| aGame aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan' with: 'Jose'.
	aCollectionOfDie := OrderedCollection with:
		                    (SequenceDie withSequence: #( 9 10 9 )).

	aGame := Game
		         withBoard: (SetBoard withTiles: 30 withAmountOfLaps:1)
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
