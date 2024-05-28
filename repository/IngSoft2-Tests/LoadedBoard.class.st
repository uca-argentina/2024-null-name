"
A loaded board with effects for testing
"
Class {
	#name : #LoadedBoard,
	#superclass : #Object,
	#instVars : [
		'tileEffectArray',
		'maxLap',
		'parsecs'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'argument validation' }
LoadedBoard class >> amountOfLapsIsValid: anAmountOfLaps [

	anAmountOfLaps strictlyPositive ifFalse: [
		Error signal: 'Cannot play with less than 1 lap' ]
]

{ #category : #'argument validation' }
LoadedBoard class >> numberOfTileIsValid: aNumberOfTiles [

	aNumberOfTiles strictlyPositive ifFalse: [
		Error signal: 'Board tiles must be greater than 0' ]
]

{ #category : #'class initialization' }
LoadedBoard class >> withLengthInTileAndParsec: aPairOfLengths  withWormHolePositions: aWormHolePair withAmountOfLaps: anAmountOfLaps withParsecArray: aParsecArray [

	self numberOfTileIsValid: aPairOfLengths first.
	self wormHolePairIsValid: aWormHolePair with: aPairOfLengths first.
	self amountOfLapsIsValid: anAmountOfLaps.

	^ self new
		  initializeWithLengths: aPairOfLengths
		  withWormHolePositions: aWormHolePair
		  withAmountOfLaps: anAmountOfLaps
		  withParsecArray: aParsecArray asOrderedCollection 
]

{ #category : #'argument validation' }
LoadedBoard class >> wormHolePairIsValid: aWormHolePair with: aNumberOfTiles [

	(aWormHolePair allSatisfy: [ :i |
		 i <= aNumberOfTiles and: i strictlyPositive ]) ifFalse: [
		Error signal: 'Wormhole tiles are out of bounds' ].
	(aWormHolePair anySatisfy: [ :i | i = 1 ]) ifTrue: [
		Error signal: 'Wormhole cannot be created in first tile of board' ].
	aWormHolePair first = aWormHolePair last ifTrue: [
		Error signal: 'Wormhole tiles cannot be in the same position' ]
]

{ #category : #accessing }
LoadedBoard >> adjustShipPositionBelowOne: aShip [

	(aShip position < 1 and: aShip lapsDone > 1) ifFalse: [ ^ self ].


	aShip modifyLap: aShip position - 1 // tileEffectArray size.
	aShip moveTiles: tileEffectArray size
		* (aShip position - 1 // tileEffectArray size) negated
]

{ #category : #accessing }
LoadedBoard >> adjustShipPositionOverboard: aShip [

	(aShip position > tileEffectArray size and: aShip lapsDone <= maxLap)
		ifFalse: [ ^ self ].

	aShip modifyLap: aShip position - 1 // tileEffectArray size.
	aShip moveTiles: tileEffectArray size
		* (aShip position - 1 // tileEffectArray size) negated
]

{ #category : #'accessing - arguments' }
LoadedBoard >> allTileEffectsAmount [

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
LoadedBoard >> applyTileEffectOn: aGame triggeredBy: aShip [

	(tileEffectArray at: aShip position) applyOn: aGame
]

{ #category : #initialization }
LoadedBoard >> initializeWithLengths: aPairOfLengths withWormHolePositions: aWormHolePair withAmountOfLaps: anAmountOfLaps withParsecArray: aParsecArray [

	| aTileEffectsCreator |
	maxLap := anAmountOfLaps.
	tileEffectArray := OrderedCollection new.
	parsecs := aPairOfLengths last.

	aTileEffectsCreator := LoadedTileEffectsCreator new.

	tileEffectArray := aTileEffectsCreator
		                   createWithWormHolePositions: aWormHolePair
		                   withBoardLenghts: aPairOfLengths
		                   withParsecArrry: aParsecArray
]

{ #category : #testing }
LoadedBoard >> isInLastTile: aShip [

	^ aShip position = 1 and: aShip lapsDone > maxLap
]

{ #category : #accessing }
LoadedBoard >> numOfParsecs [

	^ parsecs
]

{ #category : #accessing }
LoadedBoard >> numbOfTiles [

	^ tileEffectArray size
]

{ #category : #accessing }
LoadedBoard >> snapToFinishTile: aShip [

	aShip lapsDone > maxLap ifTrue: [ aShip moveToFirstTile ]
]
