"
Ship battle object
"
Class {
	#name : #ShipBattle,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #events }
ShipBattle class >> doBattleBetween: aShip and: aCollectionOfShips withDice: aCollectionOfDice [
	^(self new) initializeBattleBetween: aShip and: aCollectionOfShips withDice: aCollectionOfDice 
]

{ #category : #initialization }
ShipBattle >> initializeBattleBetween: aShip and: aCollectionOfShips withDice: aCollectionOfDice [

	dice := aCollectionOfDice.
	1 to: aCollectionOfShips size do: [ :i |
		self resolveBattleBetween: aShip and: (aCollectionOfShips at: i) ]
]

{ #category : #event }
ShipBattle >> resolveBattleBetween: aShip and: aShip2 [ 
	| aShipDiceRoll anotherShipDiceRoll |
	aShipDiceRoll := dice throw.
	anotherShipDiceRoll := dice throw.
	aShipDiceRoll > anotherShipDiceRoll
		ifTrue: [ aShip2 loseBattle ]
		ifFalse: [ aShip loseBattle ]
]
