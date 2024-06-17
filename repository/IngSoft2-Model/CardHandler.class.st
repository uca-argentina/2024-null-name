"
a
"
Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'deck',
		'probabilityCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardHandler class >> withCardProbabilities: aCollectionOfCardProbabilities [ 
	
	^ (self new) initalizeWithProbabilities: aCollectionOfCardProbabilities.
]

{ #category : #comparing }
CardHandler >> cardAtRandom [

	| aRandomNumber aCardClass |
	aRandomNumber := (1 to: 100) atRandom asInteger.

	aCardClass := ((probabilityCards detect: [ :aProbabilityCard |
		             aProbabilityCard rangeIncludes: aRandomNumber ])
		            associatedObject).

	^ aCardClass
]

{ #category : #accessing }
CardHandler >> deck [

	^ deck
]

{ #category : #initialization }
CardHandler >> initalizeWithProbabilities: aCollectionOfCardProbabilities [ 
	
	probabilityCards := self transformIntoProbabilityRanges: aCollectionOfCardProbabilities .
	deck := OrderedCollection new
]

{ #category : #generating }
CardHandler >> startingCards: aShipName [

	2 timesRepeat: [ deck add: (self cardAtRandom withHolder: aShipName) ].

]

{ #category : #comparing }
CardHandler >> transformIntoProbabilityRanges: aProbabilityDistributionCollection [

	| acc |
	acc := 0.

	aProbabilityDistributionCollection do: [ :effectProbability |
		effectProbability setRange: acc.
		acc := acc + effectProbability probability].
	^ aProbabilityDistributionCollection
]

{ #category : #comparing }
CardHandler >> validateCard: aCard [

	^ (deck select: [ :card | card = aCard ]) isEmpty
]
