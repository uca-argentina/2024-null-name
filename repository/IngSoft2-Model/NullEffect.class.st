"
null pattern implementation
"
Class {
	#name : #NullEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
NullEffect >> applyOn: aShip [ 
	aShip moveTiles: 0.
]
