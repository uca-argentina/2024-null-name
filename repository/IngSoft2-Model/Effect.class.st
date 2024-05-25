"
Superclass for tile effects
"
Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Effect class >> createWith: aCollectionOfParameters [
	self subclassResponsibility.
]

{ #category : #applying }
Effect >> applyOn: aGame [

	self subclassResponsibility.
]
