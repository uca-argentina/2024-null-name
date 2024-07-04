Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #modifying }
AccelerationCard >> activate: aCardHandler withTarget: aShipName [

	aCardHandler addToActiveCards: self
]

{ #category : #comparing }
AccelerationCard >> applyMovement [

	^ 1
]

{ #category : #comparing }
AccelerationCard >> canPlayRightNow: theShipInTurn [

	^ theShipInTurn shipName = holder
]
