Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #modifying }
RepeatCard >> activate: aCardHandler withTarget: aTarget [

	target:= aTarget.
	aCardHandler applyLastEffectOn: aTarget
]

{ #category : #comparing }
RepeatCard >> canPlayRightNow: theShipInTurn [

	^true
]
