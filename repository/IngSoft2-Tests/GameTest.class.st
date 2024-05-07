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
GameTest >> testGameCanTellAllShipPositions [
	| aGame aCollectionOfNames aCollectionOfPositions |
	
	aCollectionOfNames:= OrderedCollection new 
    add: 'Juan';
    add: 'Jose';yourself.
	
	aGame :=Game withBoard: (Board withTiles: 3) withPlayers: aCollectionOfNames withDice: (Dice with: (LoadedDie of: 9)).
	aCollectionOfPositions:= OrderedCollection new
	add: 19; add: 10; yourself.
	
	aGame playTurn .
	aGame playTurn .
	aGame playTurn .
	
	self assert: aGame giveAllShipPositions equals: aCollectionOfPositions.
]

{ #category : #tests }
GameTest >> testGameCanTellHowManyShipsArePlaying [

    | aGame aBoard aCollectionOfNames |
    aBoard := Board withTiles: 5.
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
	aShip:= Ship create.
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

	| aGame aBoard aCollectionOfNames |
	aBoard := Board withTiles: 1.
	aCollectionOfNames:= OrderedCollection new 
    add: 'Juan';yourself.
	aGame := Game withBoard: aBoard withPlayers: aCollectionOfNames.
	self assert: (aGame board) equals: aBoard
]

{ #category : #tests }
GameTest >> testGameKnowsPlayerPositions [


	| aGame arrays aCollectionOfNames |
	arrays:=OrderedCollection with:(Ship create ) with: (Ship create ).
	
	aCollectionOfNames:= OrderedCollection new 
    add: 'Juan';
    add: 'Jose';
    add:'Fran';
    add: 'Juan';yourself.
	
	aGame :=Game withBoard: (Board withTiles: 27 ) withPlayers: aCollectionOfNames withDice: (Dice with: (LoadedDie of: 9) with:(LoadedDie of:3)).
	
	aGame playTurn .
	aGame playTurn .
	aGame playTurn .
	
	
	self assert: [( ((arrays at:1) givePosition ) = 24) and: (((arrays at:2)givePosition) = 12).]
]

{ #category : #tests }
GameTest >> testGameOfOnlyOneShip [


	| aGame arrays|
	arrays:=OrderedCollection with:(Ship create ).
	
	aGame :=Game withBoard: (Board withTiles: 16 ) withPlayers: arrays    withDice: (Dice with: (LoadedDie of: 9) ).
	aGame playTurn .
	aGame playTurn .
	self assert: aGame isFinished.
]

{ #category : #tests }
GameTest >> testGameWithMoreThanOneDie [


	| aGame arrays|
	arrays:=OrderedCollection with:(Ship create ).
	
	aGame :=Game withBoard: (Board withTiles: 16 ) withPlayers: arrays    withDice: (Dice with: (LoadedDie of: 9) with:(LoadedDie of:3)).
	aGame playTurn .

	self assert:  ((arrays at:1) givePosition ) equals: 12.
]

{ #category : #tests }
GameTest >> testIfGameIsFinishedRerurnTrue [

	| aGame aBoard aShip |
	aBoard := Board withTiles: 1.
	aShip:= Ship create.
	aGame := Game withBoard: aBoard withPlayers: aShip.
	aGame endGame.

	self assert: aGame isFinished .
]

{ #category : #tests }
GameTest >> testIfGameIsNotFinishedRerurnFalse [

	| aGame aBoard aShip |
	aBoard := Board withTiles: 1.
	aShip:= Ship create.
	aGame := Game withBoard: aBoard withPlayers: aShip.

	self deny: aGame isFinished .
]

{ #category : #tests }
GameTest >> testIfThreIsAwinnerThereisNoMoreMovements [


	| aGame arrays|
	arrays:=OrderedCollection with:(Ship create ) with: (Ship create ).
	
	
	aGame :=Game withBoard: (Board withTiles: 17) withPlayers: arrays    withDice: (Dice with: (LoadedDie of: 9) with:(LoadedDie of:3)).
	
	aGame playTurn .
	aGame playTurn .
	aGame playTurn .

	
	
	self
		should:[aGame playTurn] 
		raise:Error
		withMessage:'Game is Over you cant Keep Playing'.
]

{ #category : #tests }
GameTest >> testWhenFinishedTheEndingPositionOfTheWinnerEqualsTheSizeOfTheBoard [


	| aGame arrays|
	arrays:=OrderedCollection with:(Ship create ) with: (Ship create ).
	
	
	aGame :=Game withBoard: (Board withTiles: 27 ) withPlayers: arrays    withDice: (Dice with: (LoadedDie of: 9) with:(LoadedDie of:3)).
	
	aGame playTurn .
	aGame playTurn .
	aGame playTurn .
	aGame playTurn .
	aGame playTurn .
	
	
	self assert: ((arrays at:1) givePosition ) equals: 27
]
