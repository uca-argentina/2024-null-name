"
setboard class for testing effects
"
Class {
	#name : #SetBoard,
	#superclass : #Object,
	#instVars : [
		'tileEffectArray',
		'maxLap'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'argument validation' }
SetBoard class >> amountOfLapsIsValid: anAmountOfLaps [

	anAmountOfLaps strictlyPositive ifFalse: [
		Error signal: 'Cannot play with less than 1 lap' ]
]

{ #category : #'argument validation' }
SetBoard class >> numberOfTileIsValid: aNumberOfTiles [

	aNumberOfTiles strictlyPositive ifFalse: [
		Error signal: 'Board tiles must be greater than 0' ]
]

{ #category : #'class initialization' }
SetBoard class >> withLengthInTileAndParsec: aPairOfLengths withWormHolePositions: aWormHolePair withAmountOfLaps: anAmountOfLaps [

	self numberOfTileIsValid: aPairOfLengths first.
	self wormHolePairIsValid: aWormHolePair with: aPairOfLengths first.
	self amountOfLapsIsValid: anAmountOfLaps.

	^ self new
		  initializeWithLengths: aPairOfLengths
		  withWormHolePositions: aWormHolePair
		  withEffectsInPosition: Dictionary new
		  withAmountOfLaps: anAmountOfLaps
]

{ #category : #'class initialization' }
SetBoard class >> withLengthInTileAndParsec: aPairOfLengths withWormHolePositions: aWormHolePair withAmountOfLaps: anAmountOfLaps withEffectsInPosition: aDictionaryOfEffectsAndParameters [

	self numberOfTileIsValid: aPairOfLengths first.
	self wormHolePairIsValid: aWormHolePair with: aPairOfLengths first.
	self amountOfLapsIsValid: anAmountOfLaps.

	^ self new
		  initializeWithLengths: aPairOfLengths
		  withWormHolePositions: aWormHolePair
		  withEffectsInPosition: aDictionaryOfEffectsAndParameters
		  withAmountOfLaps: anAmountOfLaps
]

{ #category : #'argument validation' }
SetBoard class >> wormHolePairIsValid: aWormHolePair with: aNumberOfTiles [

	(aWormHolePair allSatisfy: [ :i |
		 i <= aNumberOfTiles and: i strictlyPositive ]) ifFalse: [
		Error signal: 'Wormhole tiles are out of bounds' ].
	(aWormHolePair anySatisfy: [ :i | i = 1 ]) ifTrue: [
		Error signal: 'Wormhole cannot be created in first tile of board' ].
	aWormHolePair first = aWormHolePair last ifTrue: [
		Error signal: 'Wormhole tiles cannot be in the same position' ]
]

{ #category : #accessing }
SetBoard >> adjustShipPosition: aShip [

	((aShip position > tileEffectArray size and: aShip lapsDone <= maxLap)
		 or: (aShip position < 1 and: aShip lapsDone > 1)) ifFalse: [
		^ self ].

	aShip modifyLap: aShip position - 1 // tileEffectArray size.
	aShip moveTiles: tileEffectArray size
		* (aShip position - 1 // tileEffectArray size) negated
]

{ #category : #modifying }
SetBoard >> applyTileEffectOn: aGame triggeredBy: aShip [

	(tileEffectArray at: aShip position) applyOn: aGame
]

{ #category : #initialization }
SetBoard >> initializeWithLengths: aPairOfLengths withWormHolePositions: aWormHolePair withEffectsInPosition: aDictionaryOfEffectsAndParameters withAmountOfLaps: anAmountOfLaps [

	maxLap := anAmountOfLaps.
	tileEffectArray := OrderedCollection new.

	1 to: aPairOfLengths first do: [ :i |
	tileEffectArray add: (NullEffect new) ].

	1 to: aPairOfLengths first do: [ :i |
		(aDictionaryOfEffectsAndParameters includesKey: i) ifTrue: [
			tileEffectArray
				at: i
				put: (aDictionaryOfEffectsAndParameters at: i) ] ].

	tileEffectArray at: aWormHolePair first put: (WormholeEffect
			 fromPosition: aWormHolePair first
			 toPosition: aWormHolePair last).

	tileEffectArray at: aWormHolePair last put: (WormholeEffect
			 fromPosition: aWormHolePair last
			 toPosition: aWormHolePair first).
]

{ #category : #testing }
SetBoard >> isInLastTile: aShip [

	^ aShip position = 1 and: aShip lapsDone > maxLap
]

{ #category : #accessing }
SetBoard >> numbOfTiles [

	^ tileEffectArray size
]

{ #category : #accessing }
SetBoard >> snapToFinishTile: aShip [

	aShip lapsDone > maxLap ifTrue: [ aShip moveToFirstTile ]
]
