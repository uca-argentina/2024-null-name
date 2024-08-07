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
Ship >> > anotherShip [

	^ self lapsDone > anotherShip lapsDone or:
		  (self lapsDone = anotherShip lapsDone and:
			   self position > anotherShip position)
]

{ #category : #accessing }
Ship >> amountOfShieldsActive [

	^ numberOfShields
]

{ #category : #modifying }
Ship >> healFullShields [

	numberOfShields := self maxShields
]

{ #category : #accessing }
Ship >> inSamePositionAs: aShip [

	^ currentPosition = aShip position and: self ~= aShip
]

{ #category : #initialization }
Ship >> initializeInTile: aPosition withName: aName [

	currentPosition := aPosition.
	playerName := aName.
	numberOfShields := self maxShields.
	currentLap := 1
]

{ #category : #accessing }
Ship >> lapsDone [

	^ currentLap
]

{ #category : #modifying }
Ship >> loseOneShield [

	numberOfShields := numberOfShields - 1 max: 0.
]

{ #category : #initialization }
Ship >> maxShields [

	^ 3
]

{ #category : #modifying }
Ship >> modifyLap: aLapAmount [

	currentLap := currentLap + aLapAmount
]

{ #category : #modifying }
Ship >> moveTiles: anAmountOfTiles [

	currentPosition := currentLap = 1
		                   ifTrue: [
		                   currentPosition + anAmountOfTiles max: 1 ]
		                   ifFalse: [ currentPosition + anAmountOfTiles ]
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
