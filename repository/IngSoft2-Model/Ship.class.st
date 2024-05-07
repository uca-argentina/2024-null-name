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
Ship class >> create [
	^ (self new) inTile: 0.
]

{ #category : #'class initialization' }
Ship class >> createWithName: aName [ 
	^ (self new) inTile: 1 withName:aName.
]

{ #category : #accessing }
Ship >> givePosition [
	^ currentPosition.
]

{ #category : #testing }
Ship >> hasName: aName [
	^ playerName == aName
]

{ #category : #initialization }
Ship >> inTile: aPosition [
	currentPosition := aPosition.
]

{ #category : #initialization }
Ship >> inTile: aPosition withName: aName [ 
	currentPosition := aPosition.
    playerName:=aName.
]

{ #category : #modifying }
Ship >> moveTiles: anAmountOfTiles [ 
	currentPosition := currentPosition + anAmountOfTiles max: 1
]
