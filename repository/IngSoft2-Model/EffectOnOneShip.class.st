"
proof of concept
"
Class {
	#name : #EffectOnOneShip,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
EffectOnOneShip >> affectAShip: aShip [

	^ self subclassResponsibility
]

{ #category : #applying }
EffectOnOneShip >> applyOn: aGame activatedBy: aShip [

	aGame applyEffectOnOneShip: self triggeredBy: aShip
]
