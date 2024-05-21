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

{ #category : #'instance creation' }
Dice class >> with: aDieCollection [
	^(self new) inializeWith: aDieCollection
]

{ #category : #action }
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
