"
a
"
Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
SpeedCard >> applyMovement [

	^ 1
]

{ #category : #comparing }
SpeedCard >> canPlayRightNow: theShipInTurn [

	^ theShipInTurn shipName = holder
]

{ #category : #comparing }
SpeedCard >> hasTarget: aTarget [

	^ target = aTarget
]

{ #category : #comparing }
SpeedCard >> withTarget: aTarget [

	target := aTarget
]
