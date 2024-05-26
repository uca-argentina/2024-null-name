"
handles battles between ships and determines who participates
"
Class {
	#name : #ShipBattle,
	#superclass : #Object,
	#instVars : [
		'dice',
		'ships'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #events }
ShipBattle class >> withDice: aCollectionOfDice withShips: aCollectionOfShips [

	^ self new
		  initializeWithShips: aCollectionOfShips
		  withDice: aCollectionOfDice
]

{ #category : #initialization }
ShipBattle >> checkShipBattle: currentTurnShip [
	| shipsInSamePosition |
	currentTurnShip position = 1 ifTrue: [ ^self ].
	shipsInSamePosition := ships select: [ :aShip |
		                       (currentTurnShip position = aShip position)
			                       and: currentTurnShip ~= aShip ].
	shipsInSamePosition isEmpty ifFalse: [self resolveBattleBetween: currentTurnShip and: shipsInSamePosition]
]

{ #category : #initialization }
ShipBattle >> initializeWithShips: aCollectionOfShips
		  withDice: aCollectionOfDice [
	dice := aCollectionOfDice.
	ships := aCollectionOfShips.
]

{ #category : #event }
ShipBattle >> resolveBattleBetween: aShip and: aShip2 [

	| aShipDiceRoll anotherShipDiceRoll loserShip |
	aShipDiceRoll := dice throw.
	anotherShipDiceRoll := dice throw.
	loserShip := aShipDiceRoll > anotherShipDiceRoll
		             ifTrue: [ aShip2 ]
		             ifFalse: [ aShip ].
	loserShip loseOneShield.
	loserShip moveToFirstTile
]
