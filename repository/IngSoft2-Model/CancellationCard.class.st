Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
CancellationCard >> activate: aCardHandler withTarget: aCard [

	target := aCard.
	
	aCardHandler deactivate: aCard.
	aCardHandler removeFromActiveCard: target objective.
	
	aCardHandler changeLastCardTo: self.
]

{ #category : #comparing }
CancellationCard >> canPlayRightNow: theShipInTurn [

	^ true
]
