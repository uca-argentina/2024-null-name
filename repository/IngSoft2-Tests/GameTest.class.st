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
GameTest >> testGameCanBePlayedWithMoreThanOneDie [

	| aGame aCollectionOfNames |
	aCollectionOfNames := OrderedCollection new
		                      add: 'Juan';
		                      yourself.

	aGame := Game
		         withBoard: (Board withTiles: 16)
		         withPlayers: aCollectionOfNames
		         withDice:
		         (Dice with: (LoadedDie of: 9) with: (LoadedDie of: 3)).
	aGame playTurn.

	self assert: (aGame giveAllShipPositions at:1) equals: 13
]

{ #category : #tests }
GameTest >> testGameCanTellAllShipPositions [
	| aGame aCollectionOfNames aCollectionOfPositions |
	
	aCollectionOfNames:= OrderedCollection new 
    add: 'Juan';
    add: 'Jose';yourself.
	
	aGame :=Game withBoard: (Board withTiles: 30) withPlayers: aCollectionOfNames withDice: (Dice with: (LoadedDie of: 9)).
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
	aCollectionOfNames := OrderedCollection new
		                      add: 'Juan';
		                      add: 'Jose';
		                      add: 'Fran';
		                      add: 'Juan';
		                      yourself.

	aGame := Game
		         withBoard: aBoard
		         withPlayers: aCollectionOfNames
		         withDice: (Dice with: (LoadedDie of: 9)).
	self assert: aGame amountOfShips equals: 3
]

{ #category : #tests }
GameTest >> testGameCannotBeInitializedWithoutABoard [

	| aBoard aCollectionOfNames |
	aCollectionOfNames:= OrderedCollection new
   add: 'Juan'; yourself.
	self
		should: [ Game withBoard: aBoard withPlayers: aCollectionOfNames withDice: (Dice with: (LoadedDie of: 9) )]
		raise: Error
		withMessage: 'Game cannot be started without a board'
]

{ #category : #tests }
GameTest >> testGameCannotBeInitializedWithoutAtLeastOneShip [

	| aBoard aPlayerCollection |
	aBoard := Board withTiles: 5.
	self
		should: [ Game withBoard: aBoard withPlayers: aPlayerCollection withDice: (Dice with: (LoadedDie of: 9) )]
		raise: Error
		withMessage: 'Game cannot be started without at least one ship.'
]

{ #category : #tests }
GameTest >> testGameKnowTheWinnerShip [

	| aGame aCollectionOfNames|
	aCollectionOfNames:= OrderedCollection new 
    add: 'Juan';
    add: 'Jose';yourself.
	
	
	aGame :=Game withBoard: (Board withTiles: 17) withPlayers: aCollectionOfNames    withDice: (Dice with: (LoadedDie of: 9) with:(LoadedDie of:3)).
	
	aGame playTurn .
	aGame playTurn .
	aGame playTurn .
	
	self assert:  (aGame getWinnerName) equals: 'Juan'.
]

{ #category : #tests }
GameTest >> testGameKnownsOwnBoard [

	| aGame aBoard aCollectionOfNames |
	aBoard := Board withTiles: 1.
	aCollectionOfNames:= OrderedCollection new 
    add: 'Juan';yourself.
	aGame := Game withBoard: aBoard withPlayers: aCollectionOfNames withDice: (Dice with: (LoadedDie of: 9) ).
	self assert: (aGame hasBoard: aBoard).
]

{ #category : #tests }
GameTest >> testIfGameIsFinishedRerurnTrue [

	| aGame aBoard aCollectionOfNames |
	aBoard := Board withTiles: 8.
	aCollectionOfNames:= OrderedCollection new 
    add: 'Juan'; yourself.
	aGame := Game withBoard: aBoard withPlayers: aCollectionOfNames withDice: (Dice with: (LoadedDie of: 9) ).
	aGame playTurn.

	self assert: aGame isFinished .
]

{ #category : #tests }
GameTest >> testIfGameIsNotFinishedRerurnFalse [

	| aGame aBoard aCollectionOfNames |
	aBoard := Board withTiles: 1.
	aCollectionOfNames:= OrderedCollection new 
    add: 'Juan'; yourself.
	aGame := Game withBoard: aBoard withPlayers: aCollectionOfNames withDice: (Dice with: (LoadedDie of: 9) ).
	
	self deny: aGame isFinished .
]

{ #category : #tests }
GameTest >> testIfThreIsAwinnerThereisNoMoreMovements [


	| aGame aCollectionOfNames|
	aCollectionOfNames:= OrderedCollection new 
    add: 'Juan';
    add: 'Jose';yourself.
	
	
	aGame :=Game withBoard: (Board withTiles: 17) withPlayers: aCollectionOfNames    withDice: (Dice with: (LoadedDie of: 9) with:(LoadedDie of:3)).
	
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


	| aGame aCollectionOfNames|
	aCollectionOfNames:= OrderedCollection new 
    add: 'Juan';
    add: 'Jose';yourself.
	
	aGame :=Game withBoard: (Board withTiles: 27 ) withPlayers: aCollectionOfNames    withDice: (Dice with: (LoadedDie of: 9) with:(LoadedDie of:3)).
	
	aGame playTurn .
	aGame playTurn .
	aGame playTurn .
	aGame playTurn .
	aGame playTurn .
	
	
	self assert: (aGame giveAllShipPositions at:1) equals: 27
]

{ #category : #tests }
GameTest >> testWhenOneShipReachesTheEndGameIsFinished [


	| aGame aCollectionOfNames|
	aCollectionOfNames:= OrderedCollection new 
    add: 'Juan'; yourself.
	
	aGame :=Game withBoard: (Board withTiles: 16 ) withPlayers: aCollectionOfNames  withDice: (Dice with: (LoadedDie of: 9) ).
	aGame playTurn .
	aGame playTurn .
	self assert:  aGame isFinished.
]

{ #category : #tests }
GameTest >> testWhenShipInAGameLandsInWormholeEffectTileTheCorrespondingEffectIsApplied [


	| aGame aCollectionOfNames aWormHoleTilePair|
	aCollectionOfNames:= OrderedCollection new
    add: 'Juan'; yourself.
	aWormHoleTilePair:= #(10 15).
	
	aGame :=Game withBoard: (Board withTiles: 16 withWormHolePositions: aWormHoleTilePair) withPlayers: aCollectionOfNames  withDice: (Dice with: (LoadedDie of: 9) ).
	
	aGame playTurn .
	
	self assert:  (aGame giveAllShipPositions at:1) equals: 15.
]
