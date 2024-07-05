Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #event }
RepeatCard >> activate: aCardHandler withTarget: aTarget [

	target:= aTarget.
	aCardHandler applyLastEffectOn: aTarget.
	aCardHandler changeLastCardTo: self.
	
]

{ #category : #comparing }
RepeatCard >> canPlayRightNow: theShipInTurn [

	^true
]
