"
handles battles between ships and determines who participates
"
Class {
	#name : #ShipBattle,
	#superclass : #Object,
	#instVars : [
		'dice',
		'ships',
		'listOfCoalitions',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #events }
ShipBattle class >> withDice: aCollectionOfDice withShips: aCollectionOfShips [

	^ self new
		  initializeWithShips: aCollectionOfShips
		  withDice: aCollectionOfDice
]

{ #category : #adding }
ShipBattle >> addCoalition: aShipCoalition [

	| mercenaryShip |
	mercenaryShip := aShipCoalition mercenary.
	(listOfCoalitions anySatisfy: [ :coalition |
		 coalition mercenary = mercenaryShip ]) ifTrue: [
		CardExeption signal:
			'Targeted ship is already a mercenary in another coalition' ].

	listOfCoalitions add: aShipCoalition
]

{ #category : #initialization }
ShipBattle >> checkShipBattle: currentTurnShip [

	| shipsInSamePosition |
	currentTurnShip position = 1 ifTrue: [ ^ self ].
	shipsInSamePosition := ships select: [ :aShip |
		                       (currentTurnShip inSamePositionAs: aShip)
			                       and:
			                       (self
				                        coalitionBetween: currentTurnShip
				                        and: aShip) isEmpty ].
	shipsInSamePosition do: [ :aShipInSamePosition |
		currentTurnShip position = 1 ifTrue: [ ^ self ].
		self
			resolveBattleBetween: (self getMercenaries: currentTurnShip)
			and: (self getMercenaries: aShipInSamePosition) ]
]

{ #category : #initialization }
ShipBattle >> checkShipBattle: currentTurnShip withCards: aCollectionOfCards [

	| shipsInSamePosition |
	cards := aCollectionOfCards.

	currentTurnShip position = 1 ifTrue: [ ^ self ].
	shipsInSamePosition := ships select: [ :aShip |
		                       (currentTurnShip inSamePositionAs: aShip)
			                       and:
			                       (self
				                        coalitionBetween: currentTurnShip
				                        and: aShip) isEmpty ].
	shipsInSamePosition do: [ :aShipInSamePosition |
		currentTurnShip position = 1 ifTrue: [ ^ self ].
		self
			resolveBattleBetween: (self getMercenaries: currentTurnShip)
			and: (self getMercenaries: aShipInSamePosition) ]
]

{ #category : #verifying }
ShipBattle >> coalitionBetween: aShip and: anotherShip [

	^ cards select: [ :card |
		  (card holder = aShip shipName or: card target = aShip shipName)
			  and:
			  (card holder = anotherShip shipName or:
				   card target = anotherShip shipName) ]
]

{ #category : #accessing }
ShipBattle >> getMercenaries: aShip [

	| anArmy |
	anArmy := (cards select: [ :card |
		           card holder = aShip shipName ]) collect: [
		          :card | self shipWithName: (card target) ].
	anArmy add: aShip.
	
	^ anArmy
]

{ #category : #initialization }
ShipBattle >> initializeWithShips: aCollectionOfShips withDice: aCollectionOfDice [

	dice := aCollectionOfDice.
	ships := aCollectionOfShips.
	listOfCoalitions := OrderedCollection new.
	cards := OrderedCollection new.
]

{ #category : #event }
ShipBattle >> resolveBattleBetween: aShipArmy and: anotherShipArmy [

	| aShipDiceRoll anotherShipDiceRoll loserShipArmy |
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
	^ ships detect: [ :ship | ship shipName = aShipName ].
]
