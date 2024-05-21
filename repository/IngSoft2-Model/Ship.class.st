"
- ship knows current position
- ship can update its own position
"
Class {
	#name : #Ship,
	#superclass : #Object,
	#instVars : [
		'currentPosition',
		'playerName',
		'currentLap',
		'maxLap',
		'numberOfShields'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Ship class >> createWithName: aName [

	self isValid: aName.
	^ self new initializeInTile: 1 withName: aName withAmountOfLaps: 1
]

{ #category : #'class initialization' }
Ship class >> createWithName: aName withAmountOfLaps: anAmountOfLaps [

	self isValid: aName.
	^ self new
		  initializeInTile: 1
		  withName: aName
		  withAmountOfLaps: anAmountOfLaps
]

{ #category : #testing }
Ship class >> isValid: aName [

	aName isEmpty ifTrue: [
		Error signal: 'Ship cannot be created with no name' ]
]

{ #category : #modifying }
Ship >> addLap [
	currentLap := currentLap +1 .
]

{ #category : #accessing }
Ship >> currentLap [
	^ currentLap
]

{ #category : #testing }
Ship >> hasAmountOfShields: anAmountOfShields [
	^(numberOfShields = anAmountOfShields).
]

{ #category : #accessing }
Ship >> inLastLap [

	^ currentLap == maxLap
]

{ #category : #initialization }
Ship >> initializeInTile: aPosition withName: aName withAmountOfLaps: anAmountOfLaps [ 
	currentPosition := aPosition.
	playerName := aName.
	maxLap := anAmountOfLaps.
	currentLap := 1.
	numberOfShields := 3.
	
]

{ #category : #modifying }
Ship >> loseOneShield [

    (numberOfShields-1) < 0 ifTrue: [
        Error signal: 'Amount of shields cannot be less than zero' ].
    numberOfShields := numberOfShields - 1.
]

{ #category : #modifying }
Ship >> moveTiles: anAmountOfTiles [

	currentPosition := currentPosition + anAmountOfTiles max: 1
]

{ #category : #accessing }
Ship >> position [

	^ currentPosition
]

{ #category : #accessing }
Ship >> shipName [

	^ playerName
]
