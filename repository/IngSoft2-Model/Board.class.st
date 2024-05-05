"
Board class
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tileArray'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> withTiles: anumberOfTiles [ 
	| tiles |
	anumberOfTiles<=0 ifTrue:[Error signal: 'Board tiles must be greater than 0'].
	
	tiles := OrderedCollection new.
	1 to: anumberOfTiles do: [ :i | tiles add: (Tile inPosition: i) ].
	
	^ (self new) initializeWithAmoutTiles: tiles.
]

{ #category : #initialization }
Board >> initializeWithAmoutTiles: aTileArray [ 
	tileArray := aTileArray .
]

{ #category : #accessing }
Board >> numbOfTiles [
	^ tileArray size.
]
