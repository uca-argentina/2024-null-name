"
a
"
Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'deck',
		'probabilityCards',
		'activeCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardHandler class >> withCardProbabilities: aCollectionOfCardProbabilities [ 
	
	^ (self new) initalizeWithProbabilities: aCollectionOfCardProbabilities.
]

{ #category : #generating }
CardHandler >> activateCard: aCardToPlay [

	aCardToPlay activate: self
]

{ #category : #generating }
CardHandler >> activateCard: aCardToPlay withTarget: aTarget [
	
	aCardToPlay activate: self withTarget: aTarget.

]

{ #category : #comparing }
CardHandler >> addToActiveCards: aCard [

	activeCards add: aCard
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

{ #category : #'as yet unclassified' }
CardHandler >> checkTarget: aTarget [

	^ (activeCards select: [ :card | aTarget = card ]) isNotEmpty
]

{ #category : #accessing }
CardHandler >> deck [

	^ deck
]

{ #category : #'as yet unclassified' }
CardHandler >> giveCard: aCard to: aShip [ 
	deck add: (aCard withHolder: aShip).
]

{ #category : #initialization }
CardHandler >> initalizeWithProbabilities: aCollectionOfCardProbabilities [ 
	
	probabilityCards := self transformIntoProbabilityRanges: aCollectionOfCardProbabilities .
	deck := OrderedCollection new.
	activeCards := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
CardHandler >> movementCardsActivated: theShipInTurn [

	^ ((activeCards select: [ :card |
		    card hasTarget: theShipInTurn shipName ]) sum: [ :card |
		   card applyMovement ]) max: 0
]

{ #category : #comparing }
CardHandler >> removeCardFromShipDeck: aCard [

	deck
		remove: aCard
		ifAbsent: [ Error signal: 'Card was not found in Ship Deck' ]
]

{ #category : #comparing }
CardHandler >> removeFromActiveCard: aTarget [

	activeCards remove: aTarget
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
