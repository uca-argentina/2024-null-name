Class {
	#name : #Target,
	#superclass : #Object,
	#instVars : [
		'objective'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Target class >> withObjective: anObjective [

	^ self new initializeWithObjective: anObjective
]

{ #category : #initialization }
Target >> initializeWithObjective: anObjective [

	objective := anObjective.
]

{ #category : #testing }
Target >> isValidWith: aCollection and: aCardHandler [

	self subclassResponsibility
]

{ #category : #testing }
Target >> objective [

	^ objective
]
