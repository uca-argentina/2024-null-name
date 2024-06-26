"
Die that always throws a sequence
"
Class {
	#name : #SequenceDie,
	#superclass : #TestObject,
	#instVars : [
		'rollSequence',
		'currentRollPosition'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'argument validation' }
SequenceDie class >> isValid: aSequenceOfRolls [
	aSequenceOfRolls
		detect: [ :rollNumber | rollNumber < 0 ]
		ifFound: [ Error signal: 'Die cannot have faces lesser than 1' ]
]

{ #category : #'class initialization' }
SequenceDie class >> withSequence: aSequenceOfRolls [
	self isValid: aSequenceOfRolls.
	^(self new) initializeWithSequence: aSequenceOfRolls.
]

{ #category : #initialization }
SequenceDie >> initializeWithSequence: aSequenceOfRolls [

	rollSequence := aSequenceOfRolls.
	currentRollPosition := 0
]

{ #category : #accessing }
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
