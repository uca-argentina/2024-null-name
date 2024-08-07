Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
AccelerationCard >> activate: aCardHandler withTarget: aShipName [
	
	
	target := aShipName.
	aCardHandler addToActiveCards: self.
	aCardHandler changeLastCardTo: self.
]

{ #category : #comparing }
AccelerationCard >> applyMovement [

	^ 1
]

{ #category : #comparing }
AccelerationCard >> canPlayRightNow: theShipInTurn [

	^ theShipInTurn shipName = holder
]
