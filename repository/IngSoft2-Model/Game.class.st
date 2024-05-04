"
Game Class
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'isFinished',
		'gameBoard'
	],
	#classInstVars : [
		'isFinished'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> withBoard: aBoard [

	aBoard ifNil: [
		Error signal: 'Game cannot be started without a board' ].
	^ self new beginGameWith: aBoard
]

{ #category : #initialization }
Game >> beginGameWith: aBoard [
	isFinished := false.
	gameBoard := aBoard.
	
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
