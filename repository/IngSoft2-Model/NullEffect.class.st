"
NullEfect sub-clas
"
Class {
	#name : #NullEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
NullEffect >> applyOn: aShip [ 
    aShip moveTiles: 0.
]
