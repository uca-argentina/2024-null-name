Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
RedoCard >> activate: aCardHandler withTarget: aTarget [

	target := aTarget.
	aCardHandler
		activateCard: (aCardHandler lastCardPlayed class withHolder: holder)
		withTarget: aTarget
	
]

{ #category : #comparing }
RedoCard >> canPlayRightNow: theShipInTurn [

	^ true
]
