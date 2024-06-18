"
s
"
Class {
	#name : #NullCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
NullCard >> activate: aCardHandler [

	^ self
]

{ #category : #comparing }
NullCard >> canPlayRightNow: theShipInTurn [

	^true
]
