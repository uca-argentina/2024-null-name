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

{ #category : #accessing }
Game >> endGame [
	isFinished := true
]
