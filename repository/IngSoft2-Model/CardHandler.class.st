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
		'probabilityManager',
		'lastEffect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardHandler class >> withCardProbabilities: aCollectionOfCardProbabilities [ 
	
	^ (self new) initalizeWithProbabilities: aCollectionOfCardProbabilities.
]

{ #category : #generating }
CardHandler >> activateCard: aCardToPlay withTarget: aTarget [
	
	aCardToPlay activate: self withTarget: aTarget.
	aCardToPlay class = RedoCard ifFalse: [ lastCardPlayed := aCardToPlay ]

]

{ #category : #comparing }
CardHandler >> activeMercenaryCards [

	^ activeCards select: [ :card | card class = MercenaryCard ]
]

{ #category : #comparing }
CardHandler >> addToActiveCards: aCard [

	activeCards add: aCard
]

{ #category : #generating }
CardHandler >> applyLastEffectOn: aTarget [

	| aShip |
	aShip := game shipWithName: aTarget.

	(lastEffect respondsTo: #affectAShip:) ifFalse: [
		CardExeption signal: lastEffect class name
			, ' is last effect, and doesnt target a single ship' ].

	lastEffect affectAShip: aShip.

	game adjustShipPosition: aShip
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

{ #category : #comparing }
CardHandler >> lastEffect: anEffect [

	lastEffect := anEffect
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

	(deck select: [ :card | card = aCard ]) isEmpty ifTrue: [
		CardExeption signal: 'Ship does not have that card' ]
]

{ #category : #comparing }
CardHandler >> verifyCoalition: mercenaryShip [

	(self activeMercenaryCards anySatisfy: [ :card |
		 card target = mercenaryShip ]) ifTrue: [
		CardExeption signal:
			'Targeted ship is already a mercenary in another coalition' ]
]
