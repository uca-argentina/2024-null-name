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
			resolveBattleBetween:
			(gameCardHandler mercenaryOf: currentTurnShip)
			and: (gameCardHandler mercenaryOf: aShipInSamePosition) ]
]

{ #category : #initialization }
ShipBattle >> initializeWithShips: aCollectionOfShips withDice: aCollectionOfDice [

	dice := aCollectionOfDice.
	ships := aCollectionOfShips.
]

{ #category : #event }
ShipBattle >> resolveBattleBetween: aShipNameCollection and: anotherShipNameCollection [

	| aShipDiceRoll anotherShipDiceRoll loserShipArmy aShipArmy anotherShipArmy |
	aShipArmy := self shipsNames: aShipNameCollection.
	anotherShipArmy := self shipsNames: anotherShipNameCollection.

	aShipDiceRoll := 0.
	anotherShipDiceRoll := 0.
	aShipArmy size timesRepeat: [ aShipDiceRoll + dice throw ].
	anotherShipArmy size timesRepeat: [ aShipDiceRoll + dice throw ].
	loserShipArmy := aShipDiceRoll > anotherShipDiceRoll
		                 ifTrue: [ anotherShipArmy ]
		                 ifFalse: [ aShipArmy ].
	loserShipArmy do: [ :aShip |
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
