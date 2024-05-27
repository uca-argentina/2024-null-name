"
null pattern implementation
"
Class {
	#name : #NullEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
NullEffect >> affectAShip: aShip [
	
	aShip moveTiles: 0
]

{ #category : #applying }
NullEffect >> applyOn: aGame [

	^self
]
