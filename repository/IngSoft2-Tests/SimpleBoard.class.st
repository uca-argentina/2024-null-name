"
Simple board class that does not have worm holes
"
Class {
	#name : #SimpleBoard,
	#superclass : #Object,
	#instVars : [
		'tileArray'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
SimpleBoard class >> withTiles: anumberOfTiles [ 
	anumberOfTiles<=0 ifTrue:[Error signal: 'Board tiles must be greater than 0'].
	^ (self new) initializeWithAmoutTiles: anumberOfTiles.
]

{ #category : #accessing }
SimpleBoard >> applyTileEffectOn: aShip [ 
    (self effectInPosition: (aShip position)) applyOn: aShip.
]

{ #category : #accessing }
SimpleBoard >> effectInPosition: aTilePosition [ 
	^ tileArray at: aTilePosition
]

{ #category : #accessing }
SimpleBoard >> initializeWithAmoutTiles: anumberOfTiles [

	tileArray := OrderedCollection new.
	1 to: anumberOfTiles do: [ :i | tileArray add: NullEffect new ]
]

{ #category : #testing }
SimpleBoard >> isInLastTile:aShip [
	^ ((aShip position) == (tileArray size))
]

{ #category : #accessing }
SimpleBoard >> numbOfTiles [
	^ tileArray size.
]

{ #category : #accessing }
SimpleBoard >> snapToLastTile: aShip [ 
	(aShip position > tileArray size) ifTrue: [aShip moveTiles: (tileArray size - aShip position )].
]
