"
- ship knows current position
- ship can update its own position
"
Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'currentPosition'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Ship class >> create [
	^ (self new) inTile: 0.
]

{ #category : #accessing }
Ship >> givePosition [
	^ currentPosition.
]

{ #category : #initialization }
Ship >> inTile: aPosition [
	currentPosition := aPosition.
]

{ #category : #'as yet unclassified' }
Ship >> moveTiles: anAmountOfTiles [

	currentPosition := currentPosition + anAmountOfTiles.
]
