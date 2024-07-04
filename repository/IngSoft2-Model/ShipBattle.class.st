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
ShipBattle >> checkShipBattle: currentTurnShip withCardHandler: gameCardHandler [

	| shipsInSamePosition |
	currentTurnShip position = 1 ifTrue: [ ^ self ].
	shipsInSamePosition := ships select: [ :aShip |
		                       (currentTurnShip inSamePositionAs: aShip)
			                       and:
				                       ((gameCardHandler mercenaryOf:
					                         currentTurnShip) includes:
					                        aShip shipName) not ].
	shipsInSamePosition do: [ :aShipInSamePosition |
		currentTurnShip position = 1 ifTrue: [ ^ self ].
		self
			resolveBattleBetween: currentTurnShip
			and: aShipInSamePosition
			with: gameCardHandler ]
]

{ #category : #initialization }
ShipBattle >> initializeWithShips: aCollectionOfShips withDice: aCollectionOfDice [

	dice := aCollectionOfDice.
	ships := aCollectionOfShips.
]

{ #category : #event }
ShipBattle >> resolveBattleBetween: aShip and: anotherShip with: aCardHandler [

	| aShipDiceRoll anotherShipDiceRoll loserShipArmy aShipArmy anotherShipArmy |
	aShipArmy := self shipsNames: (aCardHandler mercenaryOf: aShip).
	anotherShipArmy := self shipsNames:
		                   (aCardHandler mercenaryOf: anotherShip).

	aShipDiceRoll := 0.
	anotherShipDiceRoll := 0.
	aShipArmy do: [ :aShipInArmy |
		| cardMovement |
		cardMovement := aCardHandler movementCardsActivated: aShipInArmy.
		aShipDiceRoll + dice throw + cardMovement ].

	anotherShipArmy do: [ :aShipInArmy |
		| cardMovement |
		cardMovement := aCardHandler movementCardsActivated: aShipInArmy.
		aShipDiceRoll + dice throw + cardMovement ].
	
	loserShipArmy := aShipDiceRoll > anotherShipDiceRoll
		                 ifTrue: [ anotherShipArmy ]
		                 ifFalse: [ aShipArmy ].
	loserShipArmy do: [ :aShipInArmy |
		aShip loseOneShield.
		aShip moveToFirstTile ]
]

{ #category : #event }
ShipBattle >> shipWithName: aShipName [

	^ ships detect: [ :ship | ship shipName = aShipName ]
]

{ #category : #event }
ShipBattle >> shipsNames: aShipsNameCollection [
	
	^ aShipsNameCollection collect: [ :shipName | self shipWithName: shipName  ].
]
