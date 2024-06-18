"
HyperSpaceJump class
"
Class {
	#name : #HyperSpaceJumpEffect,
	#superclass : #EffectOnOneShip,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
HyperSpaceJumpEffect >> affectAShip: aShip [
	
	aShip moveTiles: 4.
	aShip loseOneShield.
]
