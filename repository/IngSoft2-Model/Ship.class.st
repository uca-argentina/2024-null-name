"
- ship knows current position
- ship can move in board
- if ship moves to a tile beyond board's edge stay in last tile
"
Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'currentPosition',
		'myBoard'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Ship class >> inside: aBoard [ 
	^ (self new) inTile: 0 ofBoard: aBoard.
]

{ #category : #'as yet unclassified' }
Ship >> inTile: aPosition ofBoard: aBoard [ 
	currentPosition := aPosition.
	myBoard := aBoard.
]

{ #category : #'as yet unclassified' }
Ship >> moveTiles: anAmountOfTiles [

	currentPosition := currentPosition + anAmountOfTiles min:
		                   myBoard numbOfTiles
]

{ #category : #accessing }
Ship >> myBoard [
	^ myBoard
]

{ #category : #'as yet unclassified' }
Ship >> ownPosition [
	^ currentPosition.
]
