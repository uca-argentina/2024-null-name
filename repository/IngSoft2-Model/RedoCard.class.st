Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #modifying }
RedoCard >> activate: aCardHandler withTarget: aShipName [

	aCardHandler
		activateCard: (aCardHandler lastCardPlayed class withHolder: holder)
		withTarget: aShipName
]

{ #category : #comparing }
RedoCard >> canPlayRightNow: theShipInTurn [

	^ true
]
