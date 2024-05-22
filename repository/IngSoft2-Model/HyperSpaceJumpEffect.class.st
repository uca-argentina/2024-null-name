"
HyperSpaceJump class
"
Class {
	#name : #HyperSpaceJumpEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
HyperSpaceJumpEffect >> applyOn: aShip [

	aShip moveTiles: 4.
	aShip loseOneShield.
]
