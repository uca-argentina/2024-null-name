Class {
	#name : #MercenaryCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
MercenaryCard >> activate: aCardHandler withTarget: aTarget [

	target := aTarget.
	
	aCardHandler verifyCoalition: target objective.
	aCardHandler addCoalition:
		(ShipCoalition withLeader: holder andMercenary: target objective).
	aCardHandler addToActiveCards: self.
]

{ #category : #comparing }
MercenaryCard >> canPlayRightNow: theShipInTurn [

	^ theShipInTurn shipName = holder
]

{ #category : #event }
MercenaryCard >> deactivate: aCardHandler [

	aCardHandler removeCoalitionOf: holder and: target
]
