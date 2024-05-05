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
	anumberOfTiles<=0 ifTrue:[Error signal: 'Board tiles must be greater than 0'].
	^ (self new) initializeWithAmoutTiles: anumberOfTiles.
]

{ #category : #'class initialization' }
Board class >> withTiles: anumberOfTiles withWormHolePositions: aWormHoleTilePair [
	anumberOfTiles<=0 ifTrue:[Error signal: 'Board tiles must be greater than 0'].
	
	^ (self new) initializeWithAmoutTiles: anumberOfTiles  withWormHolePositions: (aWormHoleTilePair asSortedCollection).
]

{ #category : #initialization }
Board >> initializeWithAmoutTiles: anumberOfTiles [ 
	| aTileArray |
	aTileArray := OrderedCollection new.
	1 to: anumberOfTiles do: [ :i | aTileArray add: (Tile inPosition: i) ].
	tileArray:=aTileArray
]

{ #category : #initialization }
Board >> initializeWithAmoutTiles: anumberOfTiles withWormHolePositions: aWormHoleTilePair [
	| aTileArray |
	
	aTileArray := OrderedCollection new.
	1 to: anumberOfTiles do: [ :i | 
		 (aWormHoleTilePair includes: i)
		ifTrue: [ aTileArray add: (Tile inPosition: i withWormholeTo:(aWormHoleTilePair select:[:index|index ~= i]))]
		ifFalse: [aTileArray add: (Tile inPosition: i) ]].
	tileArray := aTileArray.
]

{ #category : #accessing }
Board >> numbOfTiles [
	^ tileArray size.
]

{ #category : #accessing }
Board >> tileInPosition: anTilePosition [ 
	^ tileArray at: anTilePosition
]
