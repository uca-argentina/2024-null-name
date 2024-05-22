"
setboard class for testing effects
"
Class {
	#name : #SetBoard,
	#superclass : #Object,
	#instVars : [
		'tileEffectArray'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'argument validation' }
SetBoard class >> numberOfTileIsValid: aNumberOfTiles [

	aNumberOfTiles strictlyPositive ifFalse: [
		Error signal: 'Board tiles must be greater than 0' ]
]

{ #category : #'class initialization' }
SetBoard class >> withTiles: anInteger withEffectsInPosition: aClass [ 
	self shouldBeImplemented.
]

{ #category : #initialization }
SetBoard class >> withTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair [

	self numberOfTileIsValid: aNumberOfTiles.
	self wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles.

	^ self new
		  initializeWithAmoutTiles: aNumberOfTiles
		  withWormHolePositions: aWormHoleTilePair withEffectsInPosition: Dictionary new.
]

{ #category : #'class initialization' }
SetBoard class >> withTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair withEffectsInPosition: aDictionaryOfEffects [ 
	self numberOfTileIsValid: aNumberOfTiles.
	self wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles.

	^ self new
		  initializeWithAmoutTiles: aNumberOfTiles
		  withWormHolePositions: aWormHoleTilePair
		withEffectsInPosition:aDictionaryOfEffects
]

{ #category : #'argument validation' }
SetBoard class >> wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles [

	aWormHoleTilePair do: [ :i |
		(i <= aNumberOfTiles and: i strictlyPositive) ifFalse: [
			Error signal: 'Wormhole tiles are out of bounds' ] ]
]

{ #category : #accessing }
SetBoard >> adjustPositionAfterLap: aShip [

	(aShip position > tileEffectArray size and: aShip inLastLap not)
		ifFalse: [ ^ self ].
	aShip moveTiles: tileEffectArray size negated.
	aShip completeLap 
]

{ #category : #modifying }
SetBoard >> applyTileEffectOn: aShip [

	(tileEffectArray at: aShip position) applyOn: aShip
]

{ #category : #initialization }
SetBoard >> initializeWithAmoutTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair withEffectsInPosition: aDictionaryOfEffects [

tileEffectArray := OrderedCollection new.

	1 to: aNumberOfTiles do: [ :i | tileEffectArray add: (aDictionaryOfEffects at: i ifAbsent: NullEffect ) new ].

	tileEffectArray at: aWormHoleTilePair first put: (WormholeEffect
			 fromPosition: aWormHoleTilePair first
			 toPosition: aWormHoleTilePair last).
]

{ #category : #testing }
SetBoard >> isInLastTile: aShip [

	^ aShip position = tileEffectArray size and: aShip inLastLap
]

{ #category : #accessing }
SetBoard >> numbOfTiles [

	^ tileEffectArray size
]

{ #category : #accessing }
SetBoard >> snapToLastTile: aShip [
	
	((aShip position > tileEffectArray size) and: aShip inLastLap)ifTrue: [
		aShip moveTiles: tileEffectArray size - aShip position ]
]
