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
Board class >> numberOfTileIsValid: aNumberOfTiles [

	aNumberOfTiles strictlyPositive ifFalse: [
		Error signal: 'Board tiles must be greater than 0' ]
]

{ #category : #'class initialization' }
Board class >> withTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair [

	self numberOfTileIsValid: aNumberOfTiles.
	self wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles.

	^ self new
		  initializeWithAmoutTiles: aNumberOfTiles
		  withWormHolePositions: aWormHoleTilePair
		  withAmountOfParsecs: aNumberOfTiles
		  withAmountOfLaps: 1
]

{ #category : #'class initialization' }
Board class >> withTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair withAmountOfLaps: anAmountOfLaps [

	self numberOfTileIsValid: aNumberOfTiles.
	self wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles.

	^ self new
		  initializeWithAmoutTiles: aNumberOfTiles
		  withWormHolePositions: aWormHoleTilePair
		  withAmountOfParsecs: aNumberOfTiles
		  withAmountOfLaps: anAmountOfLaps
]

{ #category : #'class initialization' }
Board class >> withTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair withParsecs: aNumberOfParsecs [

	self numberOfTileIsValid: aNumberOfTiles.
	self wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles.

	^ self new
		  initializeWithAmoutTiles: aNumberOfTiles
		  withWormHolePositions: aWormHoleTilePair
		  withAmountOfParsecs: aNumberOfParsecs
		  withAmountOfLaps: 1
]

{ #category : #'class initialization' }
Board class >> withTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair withParsecs: aNumberOfParsecs withAmountOfLaps: anAmountOfLaps [ 

	self numberOfTileIsValid: aNumberOfTiles.
	self wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles.

	^ self new
		  initializeWithAmoutTiles: aNumberOfTiles
		  withWormHolePositions: aWormHoleTilePair
		  withAmountOfParsecs: aNumberOfParsecs
		  withAmountOfLaps: anAmountOfLaps
]

{ #category : #'argument validation' }
Board class >> wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles [

	aWormHoleTilePair do: [ :i |
		(i <= aNumberOfTiles and: i strictlyPositive) ifFalse: [
			Error signal: 'Wormhole tiles are out of bounds' ] ]
]

{ #category : #accessing }
Board >> adjustShipPositionBelowOne: aShip [

	(aShip position < 1 and: aShip lapsLeft > 1) ifFalse: [ ^ self ].
	aShip moveTiles: tileEffectArray size.
	aShip modifyLap: -1
]

{ #category : #accessing }
Board >> adjustShipPositionOverboard: aShip [

	(aShip position > tileEffectArray size and: aShip lapsLeft < maxLap)
		ifFalse: [ ^ self ].
	aShip moveTiles: tileEffectArray size negated.
	aShip modifyLap: 1
]

{ #category : #modifying }
Board >> applyTileEffectOn: aGame triggeredBy: aShip [

	(tileEffectArray at: aShip position) applyOn: aGame
]

{ #category : #initialization }
Board >> initializeWithAmoutTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair withAmountOfLaps: anAmountOfLaps [

	maxLap := anAmountOfLaps.
	tileEffectArray := OrderedCollection new.

	1 to: aNumberOfTiles do: [ :i | tileEffectArray add: NullEffect new ].

	tileEffectArray
		at: aWormHoleTilePair first
		put: (WormholeEffect createWith: aWormHoleTilePair).

	tileEffectArray
		at: aWormHoleTilePair last
		put: (WormholeEffect createWith: aWormHoleTilePair reversed)
]

{ #category : #initialization }
Board >> initializeWithAmoutTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair withAmountOfParsecs: aNumberOfParsecs withAmountOfLaps: anAmountOfLaps [ 

	maxLap := anAmountOfLaps.
	tileEffectArray := OrderedCollection new.
	parsecs:= aNumberOfParsecs.

	1 to: aNumberOfTiles do: [ :i | tileEffectArray add: NullEffect new ].

	tileEffectArray
		at: aWormHoleTilePair first
		put: (WormholeEffect createWith: aWormHoleTilePair).

	tileEffectArray
		at: aWormHoleTilePair last
		put: (WormholeEffect createWith: aWormHoleTilePair reversed)
]

{ #category : #testing }
Board >> isInLastTile: aShip [

	^ aShip position = tileEffectArray size and: aShip lapsLeft = maxLap
]

{ #category : #accessing }
Board >> numOfParsecs [
	^ parsecs 
]

{ #category : #accessing }
Board >> numbOfTiles [

	^ tileEffectArray size
]

{ #category : #'accessing - arguments' }
Board >> numberBoxEffect [
	|aDictonary |
	aDictonary := Dictionary new.
	aDictonary at: HyperJumpEffect put: 20.
	aDictonary at: BlackHoleEffect put: 20.
	aDictonary at: MoonWalkEffect put: 10.
	
	^ aDictonary.
]

{ #category : #accessing }
Board >> snapToLastTile: aShip [

	(aShip position > tileEffectArray size and: aShip lapsLeft = maxLap)
		ifTrue: [ aShip moveTiles: tileEffectArray size - aShip position ]
]
