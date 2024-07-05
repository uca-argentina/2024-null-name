Class {
	#name : #LoadedDeck,
	#superclass : #TestObject,
	#instVars : [
		'deck',
		'currentCardPosition'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'class initialization' }
LoadedDeck class >> withCards: aCollectionOfCards [

	^ self new initalizeWithCards: aCollectionOfCards
]

{ #category : #generating }
LoadedDeck >> cardAtRandom [

	currentCardPosition := currentCardPosition < deck size
		                       ifTrue: [ currentCardPosition + 1 ]
		                       ifFalse: [ 1 ].
	
	^ deck at: currentCardPosition
]

{ #category : #initialization }
LoadedDeck >> initalizeWithCards: aCollectionOfCards [

	deck := aCollectionOfCards.
	currentCardPosition := 0.
]
