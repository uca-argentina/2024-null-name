Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
CancellationCard >> activate: aCardHandler withTarget: aTarget withGame: aGame [

	aCardHandler removeFromActiveCard: aTarget.
]

{ #category : #comparing }
CancellationCard >> canPlayRightNow: theShipInTurn [

	^ true
]
