Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #modifying }
CancellationCard >> activate: aCardHandler withTarget: aTarget [
	
	target:= aTarget.
	aCardHandler removeFromActiveCard: aTarget objective .
]

{ #category : #comparing }
CancellationCard >> canPlayRightNow: theShipInTurn [

	^ true
]
