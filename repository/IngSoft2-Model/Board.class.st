"
Board class

NOTE TO FUTURE SELF:
""Can implement more effects by making a collection of Effects that create diferent tiles""
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tileEffectArray'
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

{ #category : #accessing }
Board >> adjustPositionAfterLap: aShip [

	(aShip position > tileEffectArray size and: aShip inLastLap not)
		ifFalse: [ ^ self ].
	aShip moveTiles: tileEffectArray size negated.
	aShip completeLap 
]

{ #category : #modifying }
Board >> applyTileEffectOn: aShip [

	(tileEffectArray at: aShip position) applyOn: aShip
]

{ #category : #modifying }
Board >> applyTileEffectOn: aGame triggeredBy: aShip [

	(tileEffectArray at: aShip position) applyOn: aGame
]

{ #category : #initialization }
Board >> initializeWithAmoutTiles: anumberOfTiles withWormHolePositions: aWormHoleTilePair [

	tileEffectArray := OrderedCollection new.

	1 to: anumberOfTiles do: [ :i | tileEffectArray add: NullEffect new ].

	tileEffectArray at: aWormHoleTilePair first put: (WormholeEffect
			 fromPosition: aWormHoleTilePair first
			 toPosition: aWormHoleTilePair last).

	tileEffectArray at: aWormHoleTilePair last put: (WormholeEffect
			 fromPosition: aWormHoleTilePair last
			 toPosition: aWormHoleTilePair first)
]

{ #category : #testing }
Board >> isInLastTile: aShip [

	^ aShip position = tileEffectArray size and: aShip inLastLap
]

{ #category : #accessing }
Board >> numbOfTiles [

	^ tileEffectArray size
]

{ #category : #accessing }
Board >> snapToLastTile: aShip [
	
	((aShip position > tileEffectArray size) and: aShip inLastLap)ifTrue: [
		aShip moveTiles: tileEffectArray size - aShip position ]
]
