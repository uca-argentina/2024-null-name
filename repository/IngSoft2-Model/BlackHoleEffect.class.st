"
Black Hole Effect sends Ship 4 spaces back
"
Class {
	#name : #BlackHoleEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
BlackHoleEffect class >> createWith: aCollectionOfParameters [
	^ (self new)
]

{ #category : #applying }
BlackHoleEffect >> applyOn: aShip [

	aShip moveTiles: -4
]
