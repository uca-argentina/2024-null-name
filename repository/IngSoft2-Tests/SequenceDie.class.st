"
Die that always throws a sequence
"
Class {
	#name : #SequenceDie,
	#superclass : #Object,
	#instVars : [
		'rollSequence',
		'currentRollPosition'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
SequenceDie class >> isValid: aSequenceOfRolls [
	aSequenceOfRolls
		detect: [ :rollNumber | rollNumber < 3 ]
		ifFound: [ Error signal: 'Faces should be more than 2' ]
]

{ #category : #'as yet unclassified' }
SequenceDie class >> withSequence: aSequenceOfRolls [
	self isValid: aSequenceOfRolls.
	^(self new) initializeWithSequende: aSequenceOfRolls.
]

{ #category : #initialization }
SequenceDie >> initializeWithSequende: aSequenceOfRolls [

	rollSequence := aSequenceOfRolls.
	currentRollPosition := 0
]

{ #category : #'as yet unclassified' }
SequenceDie >> nextRollPosition [

	currentRollPosition := currentRollPosition < rollSequence size
		               ifTrue: [ currentRollPosition + 1 ]
		               ifFalse: [ 1 ].
	^ currentRollPosition
]

{ #category : #initialization }
SequenceDie >> throw [

	^ rollSequence at: self nextRollPosition
]
