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
	^ (self new) inTile: 1.
]

{ #category : #accessing }
Ship >> givePosition [
	^ currentPosition.
]

{ #category : #initialization }
Ship >> inTile: aPosition [
	currentPosition := aPosition.
]

{ #category : #modifying }
Ship >> moveTiles: anAmountOfTiles [

	currentPosition := currentPosition + anAmountOfTiles max: 1
]
