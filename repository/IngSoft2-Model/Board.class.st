"
Board class
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> withTiles: numberOfTiles [ 
	numberOfTiles<=0 ifTrue:[Error signal: 'Board tiles must be greater than 0'].
	^ (self new) withAmoutTiles: numberOfTiles.
]

{ #category : #accessing }
Board >> emptyTiles [
	^tiles
]

{ #category : #accessing }
Board >> numbOfTiles [
	^ tiles.
]

{ #category : #initialization }
Board >> withAmoutTiles: numOfTiles [ 
	tiles := numOfTiles .
]
