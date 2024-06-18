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
		'lastCardPlayed',
		'probabilityManager'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardHandler class >> withCardProbabilities: aCollectionOfCardProbabilities [ 
	
	^ (self new) initalizeWithProbabilities: aCollectionOfCardProbabilities.
]

{ #category : #generating }
CardHandler >> activateCard: aCardToPlay withTarget: aTarget withGame: aGame [
	
	aCardToPlay activate: self withTarget: aTarget withBlockOfCode: aGame.
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
	
	^ probabilityManager elementAtRandom: probabilityCards
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

	probabilityManager := ProbabilityManager new.

	probabilityCards := probabilityManager
		                    transformIntoProbabilityRanges:
		                    aCollectionOfCardProbabilities.
	deck := OrderedCollection new.
	activeCards := OrderedCollection new.
	lastCardPlayed := NullCard new
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
CardHandler >> validateCard: aCard [

	^ (deck select: [ :card | card = aCard ]) isEmpty
]
