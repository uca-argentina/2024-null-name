"
proof of concept
"
Class {
	#name : #EffectOnAllShipsButOne,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
EffectOnAllShipsButOne >> affectAllShips: aCollection but: aShip [

	^ self subclassResponsibility
]

{ #category : #applying }
EffectOnAllShipsButOne >> applyOn: aGame activatedBy: aShip [

	aGame applyEffectOnAllShipsButOne: self triggerByShip: aShip.
]
