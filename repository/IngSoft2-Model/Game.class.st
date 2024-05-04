"
Game Class
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'isFinished',
		'gameBoard',
		'gameShips'
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
	^ self new beginGameWith: aBoard withShips: aShipCollection
]

{ #category : #initialization }
Game >> beginGameWith: aBoard withShips: aShipCollection [
	gameBoard := aBoard.
	gameShips := aShipCollection.
	isFinished := false.
]

{ #category : #accessing }
Game >> board [
	^gameBoard
]

{ #category : #accessing }
Game >> endGame [
	isFinished := true
]

{ #category : #testing }
Game >> isOngoing [
	^ isFinished not.
]

{ #category : #accessing }
Game >> ships [
	^gameShips.
]
