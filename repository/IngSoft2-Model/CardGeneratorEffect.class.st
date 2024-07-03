"
a
"
Class {
	#name : #CardGeneratorEffect,
	#superclass : #Effect,
	#instVars : [
		'probabilityCards',
		'probabilityManager'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
CardGeneratorEffect >> applyOn: aGame activatedBy: aShip [

	aGame giveCardToCurrentShip: aShip
]
