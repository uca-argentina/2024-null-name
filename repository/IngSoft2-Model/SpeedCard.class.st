Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
SpeedCard >> activate: aCardHandler withTarget: aTarget [

	target := aTarget.
	aCardHandler addToActiveCards: self.
	aCardHandler changeLastCardTo: self.
]

{ #category : #comparing }
SpeedCard >> applyMovement [

	^ 1
]

{ #category : #comparing }
SpeedCard >> canPlayRightNow: theShipInTurn [

	^ theShipInTurn shipName = holder
]

{ #category : #comparing }
SpeedCard >> shouldApplyOn: aTarget [

	^ target objective  = aTarget
]
