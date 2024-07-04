"
s
"
Class {
	#name : #NullCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
NullCard >> activate: aCardHandler withTarget: aTarget [

	target := aTarget.
	^ self
]

{ #category : #comparing }
NullCard >> canPlayRightNow: theShipInTurn [

	^true
]
