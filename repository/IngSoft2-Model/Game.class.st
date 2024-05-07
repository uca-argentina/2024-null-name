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
		'currentTurn',
		'gameWinner'
	],
	#classInstVars : [
		'isFinished'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Game class >> withBoard: aBoard withPlayers: aNameCollection withDice: aDice [ 
	aBoard ifNil: [
		Error signal: 'Game cannot be started without a board' ].
	aNameCollection ifNil: [ 
		Error signal: 'Game cannot be started without at least one ship.' ].
	aDice ifNil: [ 
		Error signal: 'Game cannot be started without at least one die' ].
	 ^ (self new) initializeGameWith: aBoard withPlayers: (aNameCollection asSet)  withDice: aDice.
]

{ #category : #accessing }
Game >> amountOfShips [
	^ gameShips size .
]

{ #category : #accessing }
Game >> getWinnerName [
	^gameWinner getName
]

{ #category : #accessing }
Game >> giveAllShipPositions [

	^ gameShips collect: [ :i | i givePosition ]
]

{ #category : #testing }
Game >> hasBoard: aBoard [

	^ gameBoard == aBoard
]

{ #category : #initialization }
Game >> initializeGameWith: aBoard withPlayers: aNameCollection withDice: aDice [

	| aCollectionShips |
	gameBoard := aBoard.
	aCollectionShips := OrderedCollection new.
	1 to: aNameCollection size do: [ :iter |
		aCollectionShips add:
			(Ship createWithName:
				 (aNameCollection asOrderedCollection at: iter)) ].
	gameShips := aCollectionShips.
	dice := aDice.
	currentTurn := 1.
	isFinished := false
]

{ #category : #testing }
Game >> isFinished [

	^ isFinished
]

{ #category : #testing }
Game >> isOver [

	isFinished ifTrue: [
		Error signal: 'Game is Over you cant Keep Playing' ]
]

{ #category : #modifying }
Game >> nextTurn [

	currentTurn := currentTurn < gameShips size
		               ifTrue: [ currentTurn + 1 ]
		               ifFalse: [ 1 ].
	^ currentTurn
]

{ #category : #modifying }
Game >> playTurn [

	| movement player |
	self isOver.
	movement := dice throw.
	player := gameShips at: currentTurn.
	player moveTiles: movement.
	gameBoard checkPositionOf: player.

	self veifyingItIsntTheWinningMove: player.
	currentTurn := self nextTurn
]

{ #category : #accessing }
Game >> veifyingItIsntTheWinningMove: player [

	player givePosition == gameBoard numbOfTiles ifFalse: [ ^ self ].
	gameWinner := player.
	isFinished := true
]
