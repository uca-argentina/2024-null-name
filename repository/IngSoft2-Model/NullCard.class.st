"
s
"
Class {
	#name : #NullCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
NullCard >> activate: aCardHandler withTarget: aTarget withGame: aGame [

	^ self
]

{ #category : #comparing }
NullCard >> canPlayRightNow: theShipInTurn [

	^true
]
