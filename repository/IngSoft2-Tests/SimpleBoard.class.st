"
Simple board class that does not have worm holes
"
Class {
	#name : #SimpleBoard,
	#superclass : #Object,
	#instVars : [
		'tileEffectArray'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
SimpleBoard class >> withTiles: anumberOfTiles [

	anumberOfTiles <= 0 ifTrue: [
		Error signal: 'Board tiles must be greater than 0' ].
	^ self new initializeWithAmoutTiles: anumberOfTiles
]

{ #category : #accessing }
SimpleBoard >> adjustPositionAfterLap: aShip [

	(aShip position > tileEffectArray size and: aShip inLastLap not)
		ifFalse: [ ^ self ].
	aShip moveTiles: tileEffectArray size negated.
	aShip addLap
]

{ #category : #accessing }
SimpleBoard >> applyTileEffectOn: aShip [

	(tileEffectArray at: aShip position) applyOn: aShip
]

{ #category : #accessing }
SimpleBoard >> initializeWithAmoutTiles: anumberOfTiles [

	tileEffectArray := OrderedCollection new.
	1 to: anumberOfTiles do: [ :i | tileEffectArray add: NullEffect new ]
]

{ #category : #testing }
SimpleBoard >> isInLastTile: aShip [

	^ aShip position = tileEffectArray size and: aShip inLastLap
]

{ #category : #accessing }
SimpleBoard >> numbOfTiles [

	^ tileEffectArray size
]

{ #category : #accessing }
SimpleBoard >> snapToLastTile: aShip [
	
	((aShip position > tileEffectArray size) and: aShip inLastLap)ifTrue: [
		aShip moveTiles: tileEffectArray size - aShip position ]
]
