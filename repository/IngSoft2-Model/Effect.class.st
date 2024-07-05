"
Superclass for tile effects
"
Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
Effect >> applyOn: aGame activatedBy: aShip [

	self subclassResponsibility.
]

{ #category : #generators }
Effect >> generateParameters: aTileEffectCreator [

	^ self
]
