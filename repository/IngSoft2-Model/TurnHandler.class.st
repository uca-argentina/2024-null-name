"
Turn Handler Class
"
Class {
	#name : #TurnHandler,
	#superclass : #Object,
	#instVars : [
		'currentTurn',
		'turnsPerRound',
		'ships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
TurnHandler class >> withShips: anAmountOfTurns [

	^ self new initializeWithShips: anAmountOfTurns
]

{ #category : #accessing }
TurnHandler >> currentTurnShip [

	^ ships at: currentTurn
]

{ #category : #testing }
TurnHandler >> initializeWithShips: aCollectionOfShips [

	currentTurn := 1.
	turnsPerRound := aCollectionOfShips size.
	ships := aCollectionOfShips.
]

{ #category : #modifying }
TurnHandler >> nextTurn [

	currentTurn := currentTurn < turnsPerRound
		               ifTrue: [ currentTurn + 1 ]
		               ifFalse: [ 1 ].
	^ currentTurn
]
