Class {
	#name : #CardGeneratorEffect,
	#superclass : #EffectOnOneShip,
	#instVars : [
		'probabilityCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardGeneratorEffect class >> withProbabilities: aCollectionOfProbabilities [

	^ self new initalizeWithProbabilities: aCollectionOfProbabilities
]

{ #category : #applying }
CardGeneratorEffect >> affectAShip: aShip [

	^ self
]

{ #category : #applying }
CardGeneratorEffect >> applyOn: aGame [
	
	self affectAShip: self.
	aGame giveCardToCurrentShip: (self generateRandomCard)
]

{ #category : #applying }
CardGeneratorEffect >> generateRandomCard [

	| aRandomNumber aCardClass |
	aRandomNumber := (1 to: 100) atRandom asInteger.

	aCardClass := ((probabilityCards detect: [ :aProbabilityCard |
		             aProbabilityCard rangeIncludes: aRandomNumber ])
		            associatedObject).

	^ aCardClass
]

{ #category : #initialization }
CardGeneratorEffect >> initalizeWithProbabilities: aCollectionOfCardProbabilities [ 
	
	 probabilityCards := self transformIntoProbabilityRanges: aCollectionOfCardProbabilities .  
]

{ #category : #comparing }
CardGeneratorEffect >> transformIntoProbabilityRanges: aProbabilityDistributionCollection [

	| acc |
	acc := 0.

	aProbabilityDistributionCollection do: [ :effectProbability |
		effectProbability setRange: acc.
		acc := acc + effectProbability probability].
	^ aProbabilityDistributionCollection
]
