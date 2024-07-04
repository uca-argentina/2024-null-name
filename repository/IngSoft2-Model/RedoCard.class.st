Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
RedoCard >> activate: aCardHandler withTarget: aShipName [
	
	target:= aShipName.
	aCardHandler
		activateCard: (aCardHandler lastCardPlayed class withHolder: holder)
		withTarget: aShipName
]

{ #category : #comparing }
RedoCard >> canPlayRightNow: theShipInTurn [

	^ true
]
