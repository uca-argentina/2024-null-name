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
GameTest >> testGameCanTellHowManyShipsArePlaying [

	| aGame aBoard aShipCollection aCollectionOfNames |
	aBoard := Board withTiles: 5.
	aShipCollection:= Set new.
	aCollectionOfNames:= OrderedCollection new 
	add: 'Juan';
	add: 'Jose';
	add:'Fran';
	add: 'Juan';yourself.
	
	"1 to: (aSetOfNames size) do: [ :iter | aShipCollection add: (Ship createWithName: (aSetOfNames at: iter))]."
	aGame:= Game withBoard: aBoard  withPlayers: aCollectionOfNames.
	self assert: (aGame amountOfShips) equals: 3.
	
	
]

{ #category : #tests }
GameTest >> testGameCannotBeInitializedWithoutABoard [

	| aBoard aShip |
	aShip:= Ship createWithName: 'Juan'.
	self
		should: [ Game withBoard: aBoard withPlayers: aShip. ]
		raise: Error
		withMessage: 'Game cannot be started without a board'
]

{ #category : #tests }
GameTest >> testGameCannotBeInitializedWithoutAtLeastOneShip [

	| aBoard aShip |
	aBoard := Board withTiles: 5.
	self
		should: [ Game withBoard: aBoard withPlayers: aShip. ]
		raise: Error
		withMessage: 'Game cannot be started without at least one ship.'
]

{ #category : #tests }
GameTest >> testGameKnownsOwnBoard [

	| aGame aBoard aPlayer |
	aBoard := Board withTiles: 1.
	aPlayer := OrderedCollection new 
	add: 'Juan';yourself .
	aGame := Game withBoard: aBoard withPlayers: aPlayer.
	
	self assert: (aGame board) equals: aBoard
]

{ #category : #tests }
GameTest >> testIfGameIsFinishedRerurnTrue [

	| aGame aBoard aCollectionOfNames |
	aBoard := Board withTiles: 1.
	aCollectionOfNames:= OrderedCollection new 
	add: 'Juan';yourself.
	
	aGame := Game withBoard: aBoard withPlayers: aCollectionOfNames.
	aGame endGame.

	self deny: aGame isOngoing
]

{ #category : #tests }
GameTest >> testIfGameIsNotFinishedRerurnFalse [

	| aGame aBoard aCollectionOfNames |
	aBoard := Board withTiles: 1.
	aCollectionOfNames:= OrderedCollection new 
	add: 'Juan';yourself.
	
	aGame := Game withBoard: aBoard withPlayers: aCollectionOfNames.

	self assert: aGame isOngoing
]
