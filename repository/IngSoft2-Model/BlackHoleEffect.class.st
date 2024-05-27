"
black hole effect
"
Class {
	#name : #BlackHoleEffect,
	#superclass : #EffectOnOneShip,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
BlackHoleEffect >> affectAShip: aShip [

	aShip moveTiles: -4
]
