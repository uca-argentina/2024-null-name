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
		'lapsLeft',
		'lostTurnCounter'
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

	^ numberOfShields
]

{ #category : #comparing }
Ship >> canPlayTurn [

	^ lostTurnCounter = 0
]

{ #category : #modifying }
Ship >> completeLap [

	lapsLeft := lapsLeft - 1
]

{ #category : #modifying }
Ship >> healFullShields [

	numberOfShields := 3
]

{ #category : #comparing }

Ship >> inLastLap [

	^ lapsLeft = 1
]

{ #category : #initialization }
Ship >> initializeInTile: aPosition withName: aName withAmountOfLaps: anAmountOfLaps [

	currentPosition := aPosition.
	playerName := aName.
	numberOfShields := 3.
	lostTurnCounter := 0.
	lapsLeft := anAmountOfLaps
	
]

{ #category : #comparing }
Ship >> isInTheSamePositionAs: aShip [

	^ currentPosition = aShip position
]

{ #category : #accessing }
Ship >> lapsLeft [

	^ lapsLeft
]

{ #category : #modifying }
Ship >> loseBattle [

	self loseOneShield.
	self moveToFirstTile
]

{ #category : #modifying }
Ship >> loseOneShield [

    numberOfShields:= numberOfShields -1 max: 0.
	(numberOfShields = 0) ifTrue: [ lostTurnCounter := 2 ]
]

{ #category : #modifying }
Ship >> lostTurnCounterDown [

	lostTurnCounter := lostTurnCounter - 1 max: 0.
	self canPlayTurn ifTrue: [ self healFullShields ]
]

{ #category : #modifying }
Ship >> moveTiles: anAmountOfTiles [

	currentPosition := currentPosition + anAmountOfTiles max: 1
]

{ #category : #modifying }
Ship >> moveToFirstTile [

	currentPosition := 1
]

{ #category : #accessing }
Ship >> position [

	^ currentPosition
]

{ #category : #accessing }
Ship >> shipName [

	^ playerName
]
