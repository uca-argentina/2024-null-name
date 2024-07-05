Class {
	#name : #NullTarget,
	#superclass : #Target,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
NullTarget >> isValidWith: aCollection and: aCardHandler [ 
		
	^ Error signal: 'No target has been set'
]
