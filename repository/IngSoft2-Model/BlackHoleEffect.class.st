"
Black Hole Effect sends Ship 4 spaces back
"
Class {
	#name : #BlackHoleEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
BlackHoleEffect >> applyOn: aShip [

	aShip moveTiles: -4
]
