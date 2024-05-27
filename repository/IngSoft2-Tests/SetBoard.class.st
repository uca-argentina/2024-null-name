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
SetBoard class >> numberOfTileIsValid: aNumberOfTiles [

	aNumberOfTiles strictlyPositive ifFalse: [
		Error signal: 'Board tiles must be greater than 0' ]
]

{ #category : #'class initialization' }
SetBoard class >> withLengthInTileAndParsec: aPairOfLengths withWormHolePositions: aWormHoleTilePair withAmountOfLaps: anAmountOfLaps withEffectsInPosition: aDictionaryOfEffectsAndParameters [

	self numberOfTileIsValid: aPairOfLengths first.
	self
		wormHolePairIsValid: aWormHoleTilePair
		with: aPairOfLengths first.

	^ self new
		  initializeWithLengths: aPairOfLengths
		  withWormHolePositions: aWormHoleTilePair
		  withEffectsInPosition: aDictionaryOfEffectsAndParameters
		  withAmountOfLaps: anAmountOfLaps
]

{ #category : #'argument validation' }
SetBoard class >> wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles [

	aWormHoleTilePair do: [ :i |
		(i <= aNumberOfTiles and: i strictlyPositive) ifFalse: [
			Error signal: 'Wormhole tiles are out of bounds' ] ]
]

{ #category : #accessing }
SetBoard >> adjustShipPositionBelowOne: aShip [

	(aShip position < 1 and: aShip lapsDone > 1) ifFalse: [ ^ self ].
	aShip moveTiles: tileEffectArray size.
	aShip modifyLap: -1
]

{ #category : #accessing }
SetBoard >> adjustShipPositionOverboard: aShip [

	(aShip position > tileEffectArray size and: aShip lapsDone <= maxLap)
		ifFalse: [ ^ self ].
	aShip moveTiles: tileEffectArray size negated.
	aShip modifyLap: 1
]

{ #category : #modifying }
SetBoard >> applyTileEffectOn: aGame triggeredBy: aShip [

	(tileEffectArray at: aShip position) applyOn: aGame
]

{ #category : #initialization }
SetBoard >> initializeWithAmoutTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair withEffectsInPosition: aDictionaryOfEffectsAndParameters withAmountOfLaps: anAmountOfLaps [

	maxLap := anAmountOfLaps.
	tileEffectArray := OrderedCollection new.

	1 to: aNumberOfTiles do: [ :i |
	tileEffectArray add: (NullEffect createWith: #(  )) ].

	1 to: aNumberOfTiles do: [ :i |
		(aDictionaryOfEffectsAndParameters includesKey: i) ifTrue: [
			tileEffectArray
				at: i
				put: ((aDictionaryOfEffectsAndParameters at: i) first createWith:
						 (aDictionaryOfEffectsAndParameters at: i) last) ] ].

	tileEffectArray
		at: aWormHoleTilePair first
		put: (WormholeEffect createWith: aWormHoleTilePair).
	tileEffectArray
		at: aWormHoleTilePair last
		put: (WormholeEffect createWith: aWormHoleTilePair reversed)
]

{ #category : #initialization }
SetBoard >> initializeWithLengths: aPairOfLengths withWormHolePositions: aWormHoleTilePair withEffectsInPosition: aDictionaryOfEffectsAndParameters withAmountOfLaps: anAmountOfLaps [

	maxLap := anAmountOfLaps.
	tileEffectArray := OrderedCollection new.

	1 to: aPairOfLengths first do: [ :i |
	tileEffectArray add: (NullEffect createWith: #(  )) ].

	1 to: aPairOfLengths first do: [ :i |
		(aDictionaryOfEffectsAndParameters includesKey: i) ifTrue: [
			tileEffectArray
				at: i
				put: ((aDictionaryOfEffectsAndParameters at: i) first createWith:
						 (aDictionaryOfEffectsAndParameters at: i) last) ] ].

	tileEffectArray
		at: aWormHoleTilePair first
		put: (WormholeEffect createWith: aWormHoleTilePair).
	tileEffectArray
		at: aWormHoleTilePair last
		put: (WormholeEffect createWith: aWormHoleTilePair reversed)
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

	(aShip lapsDone > maxLap)
		ifTrue: [ aShip moveToFirstTile ]
]
