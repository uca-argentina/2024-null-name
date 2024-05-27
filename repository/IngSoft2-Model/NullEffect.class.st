"
null pattern implementation
"
Class {
	#name : #NullEffect,
	#superclass : #EffectOnOneShip,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
NullEffect >> affectAShip: aShip [
	
	aShip moveTiles: 0
]
