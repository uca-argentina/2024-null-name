"
HyperSpaceJump class
"
Class {
	#name : #HyperSpaceJumpEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
HyperSpaceJumpEffect class >> createWith: aCollectionOfParameters [
	^(self new)
]

{ #category : #applying }
HyperSpaceJumpEffect >> applyOn: aShip [

	aShip moveTiles: 4.
	aShip loseOneShield.
]
