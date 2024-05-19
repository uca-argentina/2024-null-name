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
		Error signal: 'Board tiles must be greater than 0' ]
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
			Error signal: 'Wormhole tiles are out of bounds' ] ]
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

	tileArray := OrderedCollection new.
	
	1 to: anumberOfTiles do: [ :i | tileArray add: NullEffect new ].
	
	tileArray at: aWormHoleTilePair first put:(WormholeEffect 
						 fromPosition: aWormHoleTilePair first
						 toPosition:aWormHoleTilePair last).
	
	tileArray at: aWormHoleTilePair last put:(WormholeEffect 
						 fromPosition: aWormHoleTilePair last
						 toPosition:aWormHoleTilePair first).

]

{ #category : #testing }
Board >> isInLastTile:aShip [
	^ (aShip position = (tileArray size))
]

{ #category : #accessing }
Board >> numbOfTiles [
	^ tileArray size.
]
