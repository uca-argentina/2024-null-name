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
		'parsecs',
		'lightYears'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'argument validation' }
Board class >> amountOfLapsIsValid: anAmountOfLaps [

	anAmountOfLaps strictlyPositive ifFalse: [
		Error signal: 'Cannot play with less than 1 lap' ]
]

{ #category : #'argument validation' }
Board class >> amountOfUnitIsValid: aBoardLength [

	(aBoardLength toUnit: Parsec) nominalValue strictlyPositive ifFalse: [
		Error signal: 'Board size in parsecs must be greater than 0' ].
	
	(aBoardLength toUnit: LightYear) nominalValue >= 3 ifFalse: [
		Error signal: 'Not enough LightYears for a single Parsec' ]
]

{ #category : #'class initialization' }
Board class >> numberOfTilesIsValid: aNumberOfTiles [

	aNumberOfTiles strictlyPositive ifFalse: [
		Error signal: 'Board tiles must be greater than 0' ]
]

{ #category : #'class initialization' }
Board class >> withTileEffectCollection: aTileEffect withLengthInUnits: aBoardLength withAmountOfLaps: anAmountOfLaps [
	
	self amountOfLapsIsValid: anAmountOfLaps.
	self numberOfTilesIsValid: aTileEffect size.
	self amountOfUnitIsValid: aBoardLength.
	
	^ self new
		  initializeWithTileEffectCollection: aTileEffect
		  withLengthInUnits: aBoardLength
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
Board >> effectInPosition: aPosition [

	^ tileEffectArray at: aPosition
]

{ #category : #initialization }
Board >> initializeWithTileEffectCollection: aTileEffectCollection withLengthInUnits: aBoardLength withAmountOfLaps: anAmountOfLaps [

	maxLap := anAmountOfLaps.
	parsecs := aBoardLength toUnit: Parsec.
	lightYears := aBoardLength toUnit: LightYear.

	tileEffectArray := aTileEffectCollection
]

{ #category : #testing }
Board >> isInLastTile: aShip [

	^ aShip position = 1 and: aShip lapsDone > maxLap
]

{ #category : #accessing }
Board >> numOfLightYears [

	^ lightYears nominalValue
]

{ #category : #accessing }
Board >> numOfParsecs [

	^ parsecs nominalValue 
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
