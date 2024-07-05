Class {
	#name : #CardTarget,
	#superclass : #Target,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
CardTarget >> isValidWith: aCollectionOfShips and: aCardHandler [ 
	
	^aCardHandler checkTarget: objective
]
