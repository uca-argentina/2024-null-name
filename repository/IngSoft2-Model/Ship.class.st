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
		'lostTurnCounter',
		'currentLap'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Ship class >> createWithName: aName [

	self isValid: aName.
	^ self new initializeInTile: 1 withName: aName
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
Ship >> healFullShields [

	numberOfShields := 3
]

{ #category : #initialization }
Ship >> initializeInTile: aPosition withName: aName [

	currentPosition := aPosition.
	playerName := aName.
	numberOfShields := 3.
	lostTurnCounter := 0.
	currentLap := 1
	
]

{ #category : #accessing }
Ship >> lapsLeft [

	^ currentLap
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
Ship >> modifyLap: aLapAmount [

	currentLap := currentLap + aLapAmount max: 1
]

{ #category : #modifying }
Ship >> moveTiles: anAmountOfTiles [

	currentPosition := (currentPosition + anAmountOfTiles < 1 and:
		                    currentLap = 1)
		                   ifFalse: [ currentPosition + anAmountOfTiles ]
		                   ifTrue: [ 1 ]
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
