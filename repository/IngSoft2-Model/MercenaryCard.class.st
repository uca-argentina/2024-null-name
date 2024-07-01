Class {
	#name : #MercenaryCard,
	#superclass : #Card,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
MercenaryCard >> activate: aCardHandler withTarget: aTarget [
	
	aCardHandler verifyCoalition: aTarget.
	aCardHandler addToActiveCards: (self withTarget: aTarget)
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
