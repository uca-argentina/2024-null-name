"
a
"
Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'deck',
		'probabilityCards',
		'activeCards',
		'game',
		'lastCardPlayed'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardHandler class >> withCardProbabilities: aCollectionOfCardProbabilities [ 
	
	^ (self new) initalizeWithProbabilities: aCollectionOfCardProbabilities.
]

{ #category : #generating }
CardHandler >> activateCard: aCardToPlay [

	aCardToPlay activate: self.
	aCardToPlay class = RedoCard ifFalse: [ lastCardPlayed := aCardToPlay ]
]

{ #category : #generating }
CardHandler >> activateCard: aCardToPlay withTarget: aTarget [
	
	aCardToPlay activate: self withTarget: aTarget.
	aCardToPlay class = RedoCard ifFalse: [ lastCardPlayed := aCardToPlay ]

]

{ #category : #comparing }
CardHandler >> addToActiveCards: aCard [

	activeCards add: aCard
]

{ #category : #generating }
CardHandler >> applyLastEffectOn: aTarget [

	game repeateEffectTo: aTarget.
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

{ #category : #'argument validation' }
CardHandler >> checkTarget: aTarget [

	^ (activeCards select: [ :card | aTarget = card ]) isNotEmpty
]

{ #category : #accessing }
CardHandler >> deck [

	^ deck
]

{ #category : #generating }
CardHandler >> forGame: aGame [

	game := aGame
]

{ #category : #modifying }
CardHandler >> giveCard: aCard to: aShip [ 
	deck add: (aCard withHolder: aShip).
]

{ #category : #initialization }
CardHandler >> initalizeWithProbabilities: aCollectionOfCardProbabilities [

	probabilityCards := self transformIntoProbabilityRanges:
		                    aCollectionOfCardProbabilities.
	deck := OrderedCollection new.
	activeCards := OrderedCollection new.
	lastCardPlayed := NullCard new.
]

{ #category : #accessing }
CardHandler >> lastCardPlayed [

	^ lastCardPlayed
]

{ #category : #modifying }
CardHandler >> movementCardsActivated: theShipInTurn [

	| sum |
	sum := 0.
	(activeCards select: [ :card |
		 card hasTarget: theShipInTurn shipName ]) do: [ :card |
		sum := sum + card applyMovement ].

	^ sum

	"((activeCards select: [ :card |
		    card hasTarget: theShipInTurn shipName ]) sum: [ :card |
		   card applyMovement ]) max: 0"
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
