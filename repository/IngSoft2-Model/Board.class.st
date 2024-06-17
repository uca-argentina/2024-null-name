"
Board class

NOTE TO FUTURE SELF:
""Can implement more effects by making a collection of Effects that create diferent tiles""
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tileEffectArray',
		'maxLap',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'argument validation' }
Board class >> amountOfLapsIsValid: anAmountOfLaps [

	anAmountOfLaps strictlyPositive ifFalse: [
		Error signal: 'Cannot play with less than 1 lap' ]
]

{ #category : #'argument validation' }
Board class >> numberOfParsecsIsValid: aNumberOfParsecs [

	aNumberOfParsecs strictlyPositive ifFalse: [
		Error signal: 'Board size in parsecs must be greater than 0' ]
]

{ #category : #'class initialization' }
Board class >> numberOfTilesIsValid: aNumberOfTiles [

	aNumberOfTiles strictlyPositive ifFalse: [
		Error signal: 'Board tiles must be greater than 0' ]
]

{ #category : #'class initialization' }
Board class >> withTileEffectCollection: aTileEffect withLengthInParsecs: aBoardLengthInParsecs withAmountOfLaps: anAmountOfLaps [
	
	self amountOfLapsIsValid: anAmountOfLaps.
	self numberOfTilesIsValid: aTileEffect size.
	self numberOfParsecsIsValid: aBoardLengthInParsecs.
	
	^ self new
		  initializeWithTileEffectCollection: aTileEffect
		  withLengthInParsecs: aBoardLengthInParsecs
		  withAmountOfLaps: anAmountOfLaps
]

{ #category : #accessing }
Board >> adjustShipPosition: aShip [

	(self shouldAdjustShipPosition: aShip) ifFalse: [ ^ self ].

	aShip modifyLap: aShip position - 1 // tileEffectArray size.
	aShip moveTiles: tileEffectArray size
		* (aShip position - 1 // tileEffectArray size) negated
]

{ #category : #'accessing - arguments' }
Board >> allTileEffectsAmount [

	| countDictionary |
	countDictionary := Dictionary new.

	tileEffectArray do: [ :effect |
		countDictionary
			at: effect class
			ifPresent: [ :count |
			countDictionary at: effect class put: count + 1 ]
			ifAbsent: [ countDictionary at: effect class put: 1 ] ].

	^ countDictionary
]

{ #category : #modifying }
Board >> applyTileEffectOn: aGame at: aPosition [

	(tileEffectArray at: aPosition) applyOn: aGame
]

{ #category : #initialization }
Board >> initializeWithTileEffectCollection: aTileEffectCollection withLengthInParsecs: aBoardLengthInParsecs withAmountOfLaps: anAmountOfLaps [

	maxLap := anAmountOfLaps.
	parsecs := aBoardLengthInParsecs.

	tileEffectArray := aTileEffectCollection
]

{ #category : #testing }
Board >> isInLastTile: aShip [

	^ aShip position = 1 and: aShip lapsDone > maxLap
]

{ #category : #accessing }
Board >> numOfParsecs [

	^ parsecs
]

{ #category : #accessing }
Board >> numbOfTiles [

	^ tileEffectArray size
]

{ #category : #accessing }
Board >> shouldAdjustShipPosition: aShip [

	^ (aShip position > tileEffectArray size and:
		   aShip lapsDone <= maxLap) or:
		  (aShip position < 1 and: aShip lapsDone > 1)
]

{ #category : #accessing }
Board >> snapToFinishTile: aShip [

	aShip lapsDone > maxLap ifTrue: [ aShip moveToFirstTile ]
]
