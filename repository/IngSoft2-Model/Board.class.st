"
Board class
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tiles',
		'tileArray'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> withTiles: anumberOfTiles [ 
	| tiles |
	anumberOfTiles<=0 ifTrue:[Error signal: 'Board tiles must be greater than 0'].
	
	tiles := OrderedCollection new.
	1 to: anumberOfTiles do: [ :iter | tiles add: Tile new ].
	
	^ (self new) initializeWithAmoutTiles: tiles.
]

{ #category : #accessing }
Board >> emptyTiles [
	^tileArray size
]

{ #category : #initialization }
Board >> initializeWithAmoutTiles: aTileArray [ 
	tileArray := aTileArray .
	tiles := tileArray size.
]

{ #category : #accessing }
Board >> numbOfTiles [
	^ tiles.
]
