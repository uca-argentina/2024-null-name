"
Game Class
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'isFinished'
	],
	#classInstVars : [
		'isFinished'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Game class >> startGame [
	^(self new) beginGame 
]

{ #category : #initialization }
Game >> beginGame [
	isFinished := false
]

{ #category : #accessing }
Game >> endGame [
	isFinished := true
]

{ #category : #testing }
Game >> isOngoing [
	^ isFinished not.
]
