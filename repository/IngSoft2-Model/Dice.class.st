"
Dice is a class that is composed of multiple Die
"
Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
Dice class >> isValid: aDieCollection [

	aDieCollection isEmpty ifTrue: [
		Error signal: 'There should be at least 1 Die' ]
]

{ #category : #'instance creation' }
Dice class >> with: aDieCollection [
	self isValid: aDieCollection.
	^(self new) inializeWith: aDieCollection
]

{ #category : #initialization }
Dice >> inializeWith: aDieCollection [
	dice := aDieCollection
]

{ #category : #action }
Dice >> numberOfDie [ 
	^dice size
]

{ #category : #action }
Dice >> throw [

	^ (dice collect: [ :die | die throw ]) sum
]
