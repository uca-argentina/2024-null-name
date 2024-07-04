Class {
	#name : #MercenaryCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #modifying }
MercenaryCard >> activate: aCardHandler withTarget: aTarget [

	target := aTarget.
	aCardHandler verifyCoalition: aTarget objective.
	aCardHandler addToActiveCards: self
]

{ #category : #comparing }
MercenaryCard >> canPlayRightNow: theShipInTurn [

	^ theShipInTurn shipName = holder
]

{ #category : #comparing }
MercenaryCard >> target [

	^ target objective
]
