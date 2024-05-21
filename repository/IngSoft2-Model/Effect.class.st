"
Superclass for tile effects
"
Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
Effect >> applyOn: aShip [

	^ self subclassResponsibility
]
