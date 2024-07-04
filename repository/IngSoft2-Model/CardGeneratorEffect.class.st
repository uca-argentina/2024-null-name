"
a
"
Class {
	#name : #CardGeneratorEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
CardGeneratorEffect >> applyOn: aGame activatedBy: aShip [

	aGame giveCardToCurrentShip: aShip
]
