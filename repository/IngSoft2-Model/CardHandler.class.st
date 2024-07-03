"
a
"
Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'probabilityCards',
		'activeCards',
		'game',
		'lastCardPlayed',
		'probabilityManager',
		'lastEffect',
		'inPlayDeck',
		'gameDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
CardHandler class >> withDeck: aDeck andGame: aGame [

	^ self new
		  initalizeWithDeck: aDeck
		  andGame: aGame
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

{ #category : #'argument validation' }
CardHandler >> checkTarget: aTarget [

	^ (activeCards select: [ :card | aTarget = card ]) isNotEmpty
]

{ #category : #modifying }
CardHandler >> giveCard: aCard to: aShip [ 
	inPlayDeck add: (aCard withHolder: aShip).
]

{ #category : #accessing }
CardHandler >> inPlayDeck [

	^ inPlayDeck
]

{ #category : #initialization }
CardHandler >> initalizeWithDeck: aDeck andGame: aGame [

	probabilityManager := ProbabilityManager new.
	
	gameDeck := aDeck.
	
"	probabilityCards := probabilityManager
		                    transformIntoProbabilityRanges:
		                    aCollectionOfCardProbabilities."
	
	inPlayDeck := OrderedCollection new.
	activeCards := OrderedCollection new.
	lastCardPlayed := NullCard new.
	game := aGame.
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
		 card shouldApplyOn: theShipInTurn shipName ]) do: [ :card |
		sum := sum + card applyMovement ].

	^ sum

	"((activeCards select: [ :card |
		    card hasTarget: theShipInTurn shipName ]) sum: [ :card |
		   card applyMovement ]) max: 0"
]

{ #category : #comparing }
CardHandler >> removeCardFromShipDeck: aCard [

	inPlayDeck
		remove: aCard
		ifAbsent: [ Error signal: 'Card was not found in Ship Deck' ]
]

{ #category : #comparing }
CardHandler >> removeFromActiveCard: aTarget [

	activeCards remove: aTarget
]

{ #category : #generating }
CardHandler >> startingCards: aShipName [

	2 timesRepeat: [
		inPlayDeck add: (gameDeck cardAtRandom withHolder: aShipName) ]
]

{ #category : #comparing }
CardHandler >> validateCard: aCard [

	(inPlayDeck select: [ :card | card = aCard ]) isEmpty ifTrue: [
		CardExeption signal: 'Ship does not have that card' ]
]

{ #category : #comparing }
CardHandler >> verifyCoalition: mercenaryShip [

	(self activeMercenaryCards anySatisfy: [ :card |
		 card target = mercenaryShip ]) ifTrue: [
		CardExeption signal:
			'Targeted ship is already a mercenary in another coalition' ]
]
