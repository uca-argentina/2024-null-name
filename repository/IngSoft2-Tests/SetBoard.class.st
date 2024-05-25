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

{ #category : #initialization }
SetBoard class >> withTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair [

	self numberOfTileIsValid: aNumberOfTiles.
	self wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles.

	^ self new
		  initializeWithAmoutTiles: aNumberOfTiles
		  withWormHolePositions: aWormHoleTilePair withEffectsInPosition: Dictionary new.
]

{ #category : #'class initialization' }
SetBoard class >> withTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair withEffectsInPosition: aDictionaryOfEffectsAndParameters [ 
	self numberOfTileIsValid: aNumberOfTiles.
	self wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles.

	^ self new
		  initializeWithAmoutTiles: aNumberOfTiles
		  withWormHolePositions: aWormHoleTilePair
		withEffectsInPosition:aDictionaryOfEffectsAndParameters
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

{ #category : #modifying }
SetBoard >> applyTileEffectOn: aGame triggeredBy: aShip [

	(tileEffectArray at: aShip position) applyOn: aGame
]

{ #category : #initialization }
SetBoard >> initializeWithAmoutTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair withEffectsInPosition: aDictionaryOfEffectsAndParameters [

	tileEffectArray := OrderedCollection new.

	1 to: aNumberOfTiles do: [ :i | tileEffectArray add: (NullEffect createWith: #()) ].

	1 to: aNumberOfTiles do: [ :i |
		(aDictionaryOfEffectsAndParameters includesKey: i) ifTrue: [
			tileEffectArray
				at: i
				put: ((aDictionaryOfEffectsAndParameters at: i) first createWith:
						 (aDictionaryOfEffectsAndParameters at: i) last) ] ].

	tileEffectArray
		at: aWormHoleTilePair first
		put: (WormholeEffect createWith:
				 (aWormHoleTilePair at: 2) - (aWormHoleTilePair at: 1)).
	tileEffectArray
		at: aWormHoleTilePair last
		put: (WormholeEffect createWith:
				 (aWormHoleTilePair at: 1) - (aWormHoleTilePair at: 2))
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
