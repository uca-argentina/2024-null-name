"
a
"
Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'activeCards',
		'game',
		'lastCardPlayed',
		'inPlayDeck',
		'gameDeck',
		'coalitions'
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

{ #category : #accessing }
CardHandler >> addCoalition: aCoalition [

	coalitions add: aCoalition
]

{ #category : #comparing }
CardHandler >> addToActiveCards: aCard [

	activeCards add: aCard
]

{ #category : #generating }
CardHandler >> applyLastEffectOn: aTarget [

	game applyLastEffectOn: aTarget
]

{ #category : #'argument validation' }
CardHandler >> checkTarget: aTarget [

	^ activeCards anySatisfy: [ :card | aTarget = card ]
]

{ #category : #generating }
CardHandler >> deactivate: aTarget [

	aTarget objective deactivate: self.

]

{ #category : #modifying }
CardHandler >> giveCardTo: aShipName [

	inPlayDeck add: (gameDeck cardAtRandom withHolder: aShipName)
]

{ #category : #accessing }
CardHandler >> inPlayDeck [

	^ inPlayDeck
]

{ #category : #initialization }
CardHandler >> initalizeWithDeck: aDeck andGame: aGame [

	gameDeck := aDeck.
	inPlayDeck := OrderedCollection new.
	activeCards := OrderedCollection new.
	lastCardPlayed := NullCard new.
	game := aGame.
	coalitions := OrderedCollection new
]

{ #category : #accessing }
CardHandler >> lastCardPlayed [

	^ lastCardPlayed
]

{ #category : #comparing }
CardHandler >> mercenaryOf: aShip [

	| mercenaryCollection |
	mercenaryCollection := OrderedCollection new.

	mercenaryCollection := (coalitions select: [ :coalition |
		                        coalition hasLeader: aShip shipName ])
		                       collect: [ :coalition | coalition mercenary ].
	
	mercenaryCollection add: aShip shipName.
	^ mercenaryCollection
]

{ #category : #modifying }
CardHandler >> movementCardsActivated: theShipInTurn [

	^ ((activeCards select: [ :card |
		    card shouldApplyOn: theShipInTurn shipName ]) sumNumbers: [
		   :card | card applyMovement ]) max: 0
]

{ #category : #comparing }
CardHandler >> removeCardFromShipDeck: aCard [

	inPlayDeck
		remove: aCard
		ifAbsent: [ Error signal: 'Card was not found in Ship Deck' ]
]

{ #category : #comparing }
CardHandler >> removeCoalitionOf: aLeader and: aMercenary [

	coalitions removeAllSuchThat: [ :coalition |
		coalition = (ShipCoalition
			withLeader: aLeader
			andMercenary: aMercenary objective) ]
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

	inPlayDeck
		detect: [ :card | card = aCard ]
		ifNone: [ CardExeption signal: 'Ship does not have that card' ]
]

{ #category : #comparing }
CardHandler >> verifyCoalition: mercenaryShip [

	(coalitions anySatisfy: [ :coalition |
		 coalition mercenary = mercenaryShip ]) ifTrue: [
		CardExeption signal:
			'Targeted ship is already a mercenary in another coalition' ]
]
