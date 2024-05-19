"
Board class

NOTE TO FUTURE SELF:
""Can implement more effects by making a collection of Effects that create diferent tiles""
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tileArray'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'argument validation' }
Board class >> numberOfTileIsValid: aNumberOfTiles [ 
	aNumberOfTiles strictlyPositive ifFalse: [
		Error signal: 'Board tiles must be greater than 0' ].
	
]

{ #category : #initialization }
Board class >> withTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair [
	
	self numberOfTileIsValid: aNumberOfTiles.
	self wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles.
	
	^ self new
		  initializeWithAmoutTiles: aNumberOfTiles
		  withWormHolePositions: aWormHoleTilePair
]

{ #category : #'argument validation' }
Board class >> wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles [ 
	aWormHoleTilePair do: [ :i |
		(i <= aNumberOfTiles and: i strictlyPositive) ifFalse: [
			Error signal: 'Wormhole tiles are out of bounds' ].
		].
	((aWormHoleTilePair at:1) = (aWormHoleTilePair at:2)) ifTrue: [
			Error signal: 'Worm Hole pair start and end position cannot be the same' ].
]

{ #category : #modifying }
Board >> applyTileEffectOn: aShip [ 
    (self effectInPosition: (aShip position)) applyOn: aShip.
]

{ #category : #accessing }
Board >> checkPositionOf: aShip [ 
	(aShip position > tileArray size) ifTrue: [aShip moveTiles: (tileArray size - aShip position )].
	self applyTileEffectOn: aShip.
]

{ #category : #accessing }
Board >> effectInPosition: aTilePosition [ 
	^ tileArray at: aTilePosition
]

{ #category : #initialization }
Board >> initializeWithAmoutTiles: anumberOfTiles withWormHolePositions: aWormHoleTilePair [

	| aTileArray |
	aTileArray := OrderedCollection new.
	1 to: anumberOfTiles do: [ :i |
		(aWormHoleTilePair includes: i)
			ifTrue: [
				aTileArray add: (WormholeEffect 
						 fromPosition: i
						 toPosition:
						 (aWormHoleTilePair detect: [ :index | index ~= i ])) ]
			ifFalse: [ aTileArray add: (NullEffect new) ] ].
	tileArray := aTileArray
]

{ #category : #testing }
Board >> isInLastTile:aShip [
	^ (aShip position = (tileArray size))
]

{ #category : #accessing }
Board >> numbOfTiles [
	^ tileArray size.
]
