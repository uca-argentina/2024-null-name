Class {
	#name : #EffectProbability,
	#superclass : #Object,
	#instVars : [
		'effect',
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
EffectProbability class >> effect: aEffect withProbability: aProbability [

	^ self new
		  initializeWithEffect: aEffect
		  withProbability: aProbability
]

{ #category : #initialization }
EffectProbability >> effect [
	^effect  
]

{ #category : #initialization }
EffectProbability >> initializeWithEffect: aEffect withProbability: aProbability [

	effect := aEffect.
	probability := aProbability
]

{ #category : #initialization }
EffectProbability >> probability [
	^probability 
]
