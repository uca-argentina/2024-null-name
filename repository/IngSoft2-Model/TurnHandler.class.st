"
Turn Handler Class
"
Class {
	#name : #TurnHandler,
	#superclass : #Object,
	#instVars : [
		'turnsPerRound',
		'ships',
		'currentTurnShip',
		'shipLostTurns'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
TurnHandler class >> withShips: anAmountOfTurns [

	^ self new initializeWithShips: anAmountOfTurns
]

{ #category : #'as yet unclassified' }
TurnHandler >> checkForShipsWithNoShield [

	ships do: [ :ship |
		((shipLostTurns at: ship) = 0 and: (ship amountOfShieldsActive = 0))
			ifTrue: [ shipLostTurns at: ship put: 2 ] ]
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
	shipLostTurns := Dictionary new.
	ships do: [ :ship | shipLostTurns at: ship put: 0 ]
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

{ #category : #accessing }
TurnHandler >> turnShipCanPlayTurn [

	| lostTurns |
	lostTurns := shipLostTurns at: currentTurnShip.

	(shipLostTurns at: currentTurnShip) > 0 ifTrue: [
		shipLostTurns at: currentTurnShip put: lostTurns - 1.
		^ TurnExeption signal: currentTurnShip shipName,' lost their turn' ].

	(currentTurnShip amountOfShieldsActive = 0 and:
		 (shipLostTurns at: currentTurnShip) = 0) ifTrue: [
		currentTurnShip healFullShields ]
]
