"
a
"
Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'deck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
CardHandler >> deck [

	^ deck
]

{ #category : #initialization }
CardHandler >> initialize [

	deck := OrderedCollection new
]

{ #category : #generating }
CardHandler >> startingCards: aShipName [

	deck add: (Card withHolder: aShipName).
	deck add: (Card withHolder: aShipName).
]

{ #category : #comparing }
CardHandler >> validateCard: aCard [

	^ (deck select: [ :card | aCard = card ]) isEmpty
]
