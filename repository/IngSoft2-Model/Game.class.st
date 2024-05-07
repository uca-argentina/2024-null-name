"
Game Class
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'isFinished',
		'gameBoard',
		'gameShips',
		'dice',
		'currentTurn'
	],
	#classInstVars : [
		'isFinished'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Game class >> withBoard: aBoard withShips: aShipCollection [
	aBoard ifNil: [
		Error signal: 'Game cannot be started without a board' ].
	aShipCollection ifNil: [ 
		Error signal: 'Game cannot be started without at least one ship.' ].
	^ self new beginGameWith: aBoard withShips: aShipCollection
]

{ #category : #'class initialization' }
Game class >> withBoard: aBoard withShips: aShipCollection withDice: aDice [ 
	aBoard ifNil: [
		Error signal: 'Game cannot be started without a board' ].
	aShipCollection ifNil: [ 
		Error signal: 'Game cannot be started without at least one ship.' ].
	aDice ifNil: [ 
		Error signal: 'Game cannot be started without at least one die' ].
	 ^(self new)beginGameWith:aBoard  withShips:aShipCollection  withDice: aDice.
]

{ #category : #accessing }
Game >> amountOfShips [
	^ gameShips size .
]

{ #category : #initialization }
Game >> beginGameWith: aBoard withShips: aShipCollection [
	gameBoard := aBoard.
	gameShips := aShipCollection.
	isFinished := false.
]

{ #category : #initialization }
Game >> beginGameWith: aBoard withShips: aShipCollection withDice: aDice [
	gameBoard := aBoard.
	gameShips := aShipCollection.
	dice:=aDice .
	currentTurn :=1.
	isFinished := false.
]

{ #category : #initialization }
Game >> board [ 
	^gameBoard .
]

{ #category : #testing }
Game >> currentTurn [
	^gameShips at:self
]

{ #category : #accessing }
Game >> endGame [
	isFinished := true
]

{ #category : #testing }
Game >> isFinished [ 
	^ isFinished .
]

{ #category : #testing }
Game >> isOver [
	isFinished ifTrue: [ Error signal: 'Game is Over you cant Keep Playing' ] .
	
]

{ #category : #modifying }
Game >> nextTurn [
	currentTurn :=currentTurn <(gameShips size) ifTrue:[currentTurn +1] ifFalse: [1].
	^currentTurn .
]

{ #category : #modifying }
Game >> playTurn [
|movement player |
	self isOver. 
	movement := dice throw.
	player:=gameShips at: currentTurn.
	player moveTiles: movement in: gameBoard  .
	self veifyingItIsntTheWinningMove:player.
	currentTurn :=self nextTurn.
	
	

]

{ #category : #accessing }
Game >> ships [ 
	^gameShips 
]

{ #category : #accessing }
Game >> veifyingItIsntTheWinningMove: player [
	
	isFinished:=player givePosition = gameBoard numbOfTiles .
	^isFinished .
]
