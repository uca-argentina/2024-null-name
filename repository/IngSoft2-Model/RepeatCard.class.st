Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
RepeatCard >> activate: aCardHandler withTarget: aTarget withBlockOfCode: aGame [

	aCardHandler applyLastEffectOn: aTarget
]

{ #category : #comparing }
RepeatCard >> canPlayRightNow: theShipInTurn [

	^true
]
