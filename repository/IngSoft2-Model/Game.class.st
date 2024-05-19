"
Game Class
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'gameBoard',
		'gameShips',
		'dice',
		'gameWinner',
		'gameTurnHandler'
	],
	#classInstVars : [
		'isFinished'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
Game class >> isValid: aBoard with: aNameCollection and: aDice [

	aNameCollection isEmpty ifTrue: [
		Error signal: 'Game cannot be created without any Ship names' ].
	aBoard ifNil: [
		Error signal: 'Game cannot be started without a board' ].
	aDice ifNil: [
		Error signal: 'Game cannot be started without at least one die' ]
]

{ #category : #'class initialization' }
Game class >> withBoard: aBoard withShipNames: aNameCollection withDice: aDice [

	self isValid: aBoard with: aNameCollection and: aDice.
	^ self new
		  initializeGameWith: aBoard
		  withShipNames: aNameCollection asSet
		  withDice: aDice
]

{ #category : #accessing }
Game >> allShipPositions [

	^ gameShips collect: [ :aShip | OrderedCollection new add:aShip position;add: aShip shipName;yourself .]
]

{ #category : #initialization }
Game >> initializeGameWith: aBoard withShipNames: aNameCollection withDice: aDice [

	| aCollectionShips |
	gameBoard := aBoard.
	aCollectionShips := OrderedCollection new.
	1 to: aNameCollection size do: [ :iter |
		aCollectionShips add:
			(Ship createWithName:
				 (aNameCollection asOrderedCollection at: iter)) ].
	gameShips := aCollectionShips.
	dice := aDice.
	gameWinner:= 'There is no winner yet'.
	gameTurnHandler:= TurnHandler withAnAmountOfTurns: (gameShips size).
]

{ #category : #testing }
Game >> isFinished [
	^ gameShips anySatisfy:  [:aShip | (gameBoard isInLastTile: aShip ) ].
]

{ #category : #modifying }
Game >> playTurn [

	| movement theShipInCurrentTurn |
	gameTurnHandler canPlayNextTurnOf: (self isFinished).
	movement := dice throw.
	theShipInCurrentTurn := gameShips at: gameTurnHandler currentTurn .
	theShipInCurrentTurn moveTiles: movement.
	gameBoard checkPositionOf: theShipInCurrentTurn.

	self veifyingItIsntTheWinningMove: theShipInCurrentTurn.
	gameTurnHandler nextTurn
]

{ #category : #accessing }
Game >> veifyingItIsntTheWinningMove: aShip [
	self isFinished ifFalse: [ ^ self ].
	gameWinner := aShip shipName.
]

{ #category : #accessing }
Game >> winnerName [
	^gameWinner
]
