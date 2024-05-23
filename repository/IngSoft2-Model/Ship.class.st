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
		'numberOfShields',
		'lapsLeft'
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

{ #category : #accessing }
Ship >> amountOfShieldsActive [
	^numberOfShields.
]

{ #category : #modifying }
Ship >> completeLap [
	lapsLeft  := lapsLeft - 1 .
]

{ #category : #testing }
Ship >> hasAmountOfShields: anAmountOfShields [
	^(numberOfShields = anAmountOfShields).
]

{ #category : #accessing }
Ship >> inLastLap [

	^ lapsLeft = 1
]

{ #category : #initialization }
Ship >> initializeInTile: aPosition withName: aName withAmountOfLaps: anAmountOfLaps [

	currentPosition := aPosition.
	playerName := aName.
	numberOfShields := 3.
	lapsLeft := anAmountOfLaps
	
]

{ #category : #accessing }
Ship >> lapsLeft [
	^ lapsLeft 
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
