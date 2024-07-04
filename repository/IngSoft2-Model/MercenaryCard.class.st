Class {
	#name : #MercenaryCard,
	#superclass : #Card,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #modifying }
MercenaryCard >> activate: aCardHandler withTarget: aTarget [
	
	aCardHandler verifyCoalition: aTarget objective.
	aCardHandler addToActiveCards: (self withTarget: aTarget objective)
]

{ #category : #comparing }
MercenaryCard >> canPlayRightNow: theShipInTurn [

	^ theShipInTurn shipName = holder
]

{ #category : #comparing }
MercenaryCard >> target [

	^ target
]

{ #category : #comparing }
MercenaryCard >> withTarget: aTarget [

	target := aTarget.
]
