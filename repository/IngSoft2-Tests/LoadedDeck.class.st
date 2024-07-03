Class {
	#name : #LoadedDeck,
	#superclass : #TestObject,
	#instVars : [
		'deck',
		'currentCardPosition'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'as yet unclassified' }
LoadedDeck class >> withCards: aCollectionOfCards [

	^ self new initalizeWithCards: aCollectionOfCards
]

{ #category : #'as yet unclassified' }
LoadedDeck >> cardAtRandom [

	currentCardPosition := currentCardPosition < deck size
		                       ifTrue: [ currentCardPosition + 1 ]
		                       ifFalse: [ 1 ].
	
	^ deck at: currentCardPosition
]

{ #category : #'as yet unclassified' }
LoadedDeck >> initalizeWithCards: aCollectionOfCards [

	deck := aCollectionOfCards.
	currentCardPosition := 0.
]
