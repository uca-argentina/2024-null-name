"
associates effects and their generation probability
"
Class {
	#name : #ProbabilityAssociation,
	#superclass : #Object,
	#instVars : [
		'probability',
		'lowerBound',
		'upperBound',
		'associatedObject'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
ProbabilityAssociation class >> associate: anObject withProbability: aProbability [

	
	^ self new
		  initializeWithAssociation: anObject
		  withProbability: aProbability
	
]

{ #category : #initialization }
ProbabilityAssociation >> associatedObject [

	^ associatedObject value
]

{ #category : #initialization }
ProbabilityAssociation >> initializeWithAssociation: anObject withProbability: aProbability [

	associatedObject := anObject.
	probability := aProbability.
]

{ #category : #initialization }
ProbabilityAssociation >> probability [

	^ probability
]

{ #category : #testing }
ProbabilityAssociation >> rangeIncludes: aNumber [

	^  aNumber between: lowerBound  and: upperBound.
]

{ #category : #initialization }
ProbabilityAssociation >> setRange: aLowerBound [

	lowerBound := aLowerBound.
	upperBound := aLowerBound + probability
]
