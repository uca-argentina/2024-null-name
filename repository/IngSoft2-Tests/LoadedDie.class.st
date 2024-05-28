"
Loaded Die class
"
Class {
	#name : #LoadedDie,
	#superclass : #TestObject,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedDie class >> isValid: anAmountOfFaces [

	anAmountOfFaces < 3 ifTrue: [
		Error signal: 'Faces should be more than 2' ]
]

{ #category : #'instance creation' }
LoadedDie class >> of: anAmountOfFaces [

	self isValid: anAmountOfFaces.

	^ self new initializeOf: anAmountOfFaces
]

{ #category : #initialization }
LoadedDie >> initializeOf: anAmountOfFaces [

	faces := anAmountOfFaces
]

{ #category : #initialization }
LoadedDie >> throw [

	^ faces
]
