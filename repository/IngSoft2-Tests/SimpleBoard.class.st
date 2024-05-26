"
Simple board class that does not have worm holes
"
Class {
	#name : #SimpleBoard,
	#superclass : #Object,
	#instVars : [
		'tileEffectArray',
		'maxLap'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
SimpleBoard class >> withTiles: anumberOfTiles [

	anumberOfTiles <= 0 ifTrue: [
		Error signal: 'Board tiles must be greater than 0' ].
	^ self new initializeWithAmoutTiles: anumberOfTiles withAmountOfLaps: 1.
]

{ #category : #initialization }
SimpleBoard class >> withTiles: anumberOfTiles withAmountOfLaps: anAmountOfLaps [

	anumberOfTiles <= 0 ifTrue: [
		Error signal: 'Board tiles must be greater than 0' ].
	^ self new initializeWithAmoutTiles: anumberOfTiles withAmountOfLaps: anAmountOfLaps
]

{ #category : #accessing }
SimpleBoard >> adjustShipPositionBelowOne: aShip [

	(aShip position < 1 and: aShip lapsLeft > 1) ifFalse: [ ^ self ].
	aShip moveTiles: tileEffectArray size.
	aShip modifyLap: -1
]

{ #category : #accessing }
SimpleBoard >> adjustShipPositionOverboard: aShip [

	(aShip position > tileEffectArray size and: aShip lapsLeft < maxLap)
		ifFalse: [ ^ self ].
	aShip moveTiles: tileEffectArray size negated.
	aShip modifyLap: 1
]

{ #category : #accessing }
SimpleBoard >> applyTileEffectOn: aGame triggeredBy: aShip [

	(tileEffectArray at: aShip position) applyOn: aGame
]

{ #category : #accessing }
SimpleBoard >> initializeWithAmoutTiles: anumberOfTiles withAmountOfLaps: anAmountOfLaps [

	maxLap := anAmountOfLaps.
	tileEffectArray := OrderedCollection new.
	1 to: anumberOfTiles do: [ :i | tileEffectArray add: NullEffect new ]
]

{ #category : #testing }
SimpleBoard >> isInLastTile: aShip [

	^ aShip position = tileEffectArray size and: aShip lapsLeft = maxLap
]

{ #category : #accessing }
SimpleBoard >> numbOfTiles [

	^ tileEffectArray size
]

{ #category : #accessing }
SimpleBoard >> snapToLastTile: aShip [

	(aShip position > tileEffectArray size and: aShip lapsLeft = maxLap)
		ifTrue: [ aShip moveTiles: tileEffectArray size - aShip position ]
]
