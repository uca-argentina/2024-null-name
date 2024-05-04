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
