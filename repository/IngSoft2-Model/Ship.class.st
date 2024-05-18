"
- ship knows current position
- ship can update its own position
"
Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'currentPosition',
		'playerName'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Ship class >> createWithName: aName [ 
	^ (self new) initializeInTile: 1 withName:aName.
]

{ #category : #initialization }
Ship >> initializeInTile: aPosition withName: aName [

	currentPosition := aPosition.
	playerName := aName
]

{ #category : #modifying }
Ship >> moveTiles: anAmountOfTiles [

	currentPosition := currentPosition + anAmountOfTiles max: 1
]

{ #category : #accessing }
Ship >> position [

	^ currentPosition
]

{ #category : #private }
Ship >> shipName [
	^playerName
]
