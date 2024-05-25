"
null pattern implementation
"
Class {
	#name : #NullEffect,
	#superclass : #EffectOnOneShip,
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
NullEffect class >> createWith: aCollectionOfParameters [
	^(self new)
]

{ #category : #applying }
NullEffect >> affectAShip: aShip [
	
	aShip moveTiles: 0
]
