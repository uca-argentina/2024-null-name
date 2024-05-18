"
A
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
SimpleBoard >> checkPositionOf: aShip [ 
	(aShip position > tileArray size) ifTrue: [aShip moveTiles: (tileArray size - aShip position )].
	self tileEffectOn: aShip.
]

{ #category : #accessing }
SimpleBoard >> effectInPosition: aTilePosition [ 
	^ tileArray at: aTilePosition
]

{ #category : #accessing }
SimpleBoard >> initializeWithAmoutTiles: anumberOfTiles [

	| aTileCollection |
	aTileCollection := OrderedCollection new.
	1 to: anumberOfTiles do: [ :i |
	aTileCollection add: (NullEffect new) ].
	tileArray := aTileCollection
]

{ #category : #accessing }
SimpleBoard >> numbOfTiles [
	^ tileArray size.
]

{ #category : #accessing }
SimpleBoard >> tileEffectOn: aShip [ 
    (self effectInPosition: (aShip position)) applyOn: aShip.
]
