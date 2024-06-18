Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
RedoCard >> activate: aCardHandler withTarget: aShipName withBlockOfCode: aGame [

	aCardHandler
		activateCard: (aCardHandler lastCardPlayed class withHolder: holder)
		withTarget: aShipName
		withGame: aGame
]

{ #category : #comparing }
RedoCard >> canPlayRightNow: theShipInTurn [

	^ true
]
