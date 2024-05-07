"
Board class
"
Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'tileArray'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> withTiles: anumberOfTiles [ 
	anumberOfTiles<=0 ifTrue:[Error signal: 'Board tiles must be greater than 0'].
	^ (self new) initializeWithAmoutTiles: anumberOfTiles.
]

{ #category : #initialization }
Board class >> withTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair [

	aNumberOfTiles strictlyPositive ifFalse: [
		Error signal: 'Board tiles must be greater than 0' ].
	aWormHoleTilePair do: [ :i |
		(i <= aNumberOfTiles and: i strictlyPositive) ifFalse: [
			Error signal: 'Wormhole tiles are out of bounds' ] ].

	^ self new
		  initializeWithAmoutTiles: aNumberOfTiles
		  withWormHolePositions: aWormHoleTilePair
]

{ #category : #initialization }
Board >> initializeWithAmoutTiles: anumberOfTiles [ 
	| aTileCollection |
	aTileCollection := OrderedCollection new.
	1 to: anumberOfTiles do: [ :i | aTileCollection add: (Tile inPosition: i) ].
	tileArray:=aTileCollection
]

{ #category : #initialization }
Board >> initializeWithAmoutTiles: anumberOfTiles withWormHolePositions: aWormHoleTilePair [
	| aTileArray |

	aTileArray := OrderedCollection new.
	1 to: anumberOfTiles do: [ :i | 
		 (aWormHoleTilePair includes: i)
		ifTrue: [ aTileArray add: (Tile inPosition: i withWormholeTo:(aWormHoleTilePair detect:[:index|index ~= i]))]
		ifFalse: [aTileArray add: (Tile inPosition: i) ]].
	tileArray := aTileArray.
]

{ #category : #accessing }
Board >> numbOfTiles [
	^ tileArray size.
]

{ #category : #modifying }
Board >> tileEffectOn: aShip [ 
    (self tileInPosition: (aShip givePosition)) applyEffectOn: aShip.
]

{ #category : #accessing }
Board >> tileInPosition: aTilePosition [ 
	^ tileArray at: aTilePosition
]

{ #category : #accessing }
Board >> validatePositionOf: aShip [ 
	(aShip givePosition > tileArray size) ifTrue: [aShip moveTiles: (tileArray size - aShip givePosition )]
]
