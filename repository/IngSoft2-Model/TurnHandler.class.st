"
Turn Handler Class
"
Class {
	#name : #TurnHandler,
	#superclass : #Object,
	#instVars : [
		'currentTurn',
		'turnsPerRound'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
TurnHandler class >> withAnAmountOfTurns: anAmountOfTurns [

	^ self new initializeWithAmountOfTurns: anAmountOfTurns
]

{ #category : #testing }
TurnHandler >> canPlayNextTurnOf: aGameStatus [

	aGameStatus ifTrue: [
		Error signal: 'Game is Over you cant Keep Playing' ]
]

{ #category : #modifying }
TurnHandler >> currentTurn [

	^ currentTurn
]

{ #category : #testing }
TurnHandler >> initializeWithAmountOfTurns: anAmountOfTurns [

	currentTurn := 1.
	turnsPerRound := anAmountOfTurns
]

{ #category : #modifying }
TurnHandler >> nextTurn [

	currentTurn := currentTurn < turnsPerRound
		               ifTrue: [ currentTurn + 1 ]
		               ifFalse: [ 1 ].
	^ currentTurn
]
