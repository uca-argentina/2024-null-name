"
null pattern implementation
"
Class {
	#name : #NullEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
NullEffect class >> createWith: aCollectionOfParameters [
	^(self new)
]

{ #category : #applying }
NullEffect >> applyOn: aShip [

	aShip moveTiles: 0
]
