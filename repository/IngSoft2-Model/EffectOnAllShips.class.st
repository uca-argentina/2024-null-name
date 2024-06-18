"
proof of concept
"
Class {
	#name : #EffectOnAllShips,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
EffectOnAllShips >> affectAShipCollection: aShipCollection [

	^ self subclassResponsibility
]

{ #category : #applying }
EffectOnAllShips >> applyOn: aGame [

	aGame applyEffectOnAllShips: self
]
