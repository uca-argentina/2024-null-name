Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'currentPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Ship class >> inside: aBoard [ 
	^ (self new) inTile: 0.
]

{ #category : #'as yet unclassified' }
Ship >> inTile: aPosition [ 
	currentPosition := aPosition
]

{ #category : #'as yet unclassified' }
Ship >> ownPosition [
	^ currentPosition.
]
