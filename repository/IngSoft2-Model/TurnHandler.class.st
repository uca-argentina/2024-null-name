"
Turn Handler Class
"
Class {
	#name : #TurnHandler,
	#superclass : #Object,
	#instVars : [
		'turnsPerRound',
		'ships',
		'currentTurnShip'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
TurnHandler class >> withShips: anAmountOfTurns [

	^ self new initializeWithShips: anAmountOfTurns
]

{ #category : #accessing }
TurnHandler >> currentTurnShip [

	^ currentTurnShip
]

{ #category : #testing }
TurnHandler >> initializeWithShips: aCollectionOfShips [

	currentTurnShip := aCollectionOfShips first.
	turnsPerRound := aCollectionOfShips size.
	ships := aCollectionOfShips.
]

{ #category : #modifying }
TurnHandler >> nextTurn [

	| turnNumber |
	turnNumber := ships indexOf: currentTurnShip.
	currentTurnShip := turnNumber < turnsPerRound
		                   ifTrue: [ ships at: turnNumber + 1 ]
		                   ifFalse: [ ships at: 1 ].
	^ currentTurnShip
]
