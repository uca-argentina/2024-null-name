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
LoadedBoard class >> numberOfTileIsValid: aNumberOfTiles [

	aNumberOfTiles strictlyPositive ifFalse: [
		Error signal: 'Board tiles must be greater than 0' ]
]

{ #category : #'class initialization' }
LoadedBoard class >> withTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair [

	self numberOfTileIsValid: aNumberOfTiles.
	self wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles.

	^ self new
		  initializeWithAmoutTiles: aNumberOfTiles
		  withWormHolePositions: aWormHoleTilePair
		  withAmountOfParsecs: aNumberOfTiles
		  withAmountOfLaps: 1
]

{ #category : #'class initialization' }
LoadedBoard class >> withTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair withAmountOfLaps: anAmountOfLaps [

	self numberOfTileIsValid: aNumberOfTiles.
	self wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles.

	^ self new
		  initializeWithAmoutTiles: aNumberOfTiles
		  withWormHolePositions: aWormHoleTilePair
		  withAmountOfParsecs: aNumberOfTiles
		  withAmountOfLaps: anAmountOfLaps
]

{ #category : #'class initialization' }
LoadedBoard class >> withTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair withParsecs: aNumberOfParsecs [

	self numberOfTileIsValid: aNumberOfTiles.
	self wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles.

	^ self new
		  initializeWithAmoutTiles: aNumberOfTiles
		  withWormHolePositions: aWormHoleTilePair
		  withAmountOfParsecs: aNumberOfParsecs
		  withAmountOfLaps: 1
]

{ #category : #'class initialization' }
LoadedBoard class >> withTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair withParsecs: aNumberOfParsecs withAmountOfLaps: anAmountOfLaps [ 

	self numberOfTileIsValid: aNumberOfTiles.
	self wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles.

	^ self new
		  initializeWithAmoutTiles: aNumberOfTiles
		  withWormHolePositions: aWormHoleTilePair
		  withAmountOfParsecs: aNumberOfParsecs
		  withAmountOfLaps: anAmountOfLaps
]

{ #category : #'argument validation' }
LoadedBoard class >> wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles [

	aWormHoleTilePair do: [ :i |
		(i <= aNumberOfTiles and: i strictlyPositive) ifFalse: [
			Error signal: 'Wormhole tiles are out of bounds' ] ]
]

{ #category : #accessing }
LoadedBoard >> adjustShipPositionBelowOne: aShip [

	(aShip position < 1 and: aShip lapsLeft > 1) ifFalse: [ ^ self ].
	aShip moveTiles: tileEffectArray size.
	aShip modifyLap: -1
]

{ #category : #accessing }
LoadedBoard >> adjustShipPositionOverboard: aShip [

	(aShip position > tileEffectArray size and: aShip lapsLeft < maxLap)
		ifFalse: [ ^ self ].
	aShip moveTiles: tileEffectArray size negated.
	aShip modifyLap: 1
]

{ #category : #modifying }
LoadedBoard >> applyTileEffectOn: aGame triggeredBy: aShip [

	(tileEffectArray at: aShip position) applyOn: aGame
]

{ #category : #initialization }
LoadedBoard >> initializeWithAmoutTiles: aNumberOfTiles withWormHolePositions: aWormHoleTilePair withAmountOfParsecs: aNumberOfParsecs withAmountOfLaps: anAmountOfLaps [

	| aPairOfLengths aTileEffectsCreator |
	maxLap := anAmountOfLaps.
	tileEffectArray := OrderedCollection new.
	parsecs := aNumberOfParsecs.

	aPairOfLengths := OrderedCollection
		                  with: aNumberOfTiles
		                  with: aNumberOfParsecs.
	
	aTileEffectsCreator := LoadedTileEffectsCreator new.

	tileEffectArray := aTileEffectsCreator
		                   createWithWormHolePositions: aWormHoleTilePair
		                   withBoardLenghts: aPairOfLengths.

]

{ #category : #testing }
LoadedBoard >> isInLastTile: aShip [

	^ aShip position = tileEffectArray size and: aShip lapsLeft = maxLap
]

{ #category : #accessing }
LoadedBoard >> numOfParsecs [
	^ parsecs 
]

{ #category : #accessing }
LoadedBoard >> numbOfTiles [

	^ tileEffectArray size
]

{ #category : #'accessing - arguments' }
LoadedBoard >> numberBoxEffect [
	|countDictionary |

    countDictionary := Dictionary new.
    
    tileEffectArray do: [:effect | 
        | className |
        className := effect class .
        countDictionary at: className ifPresent: [:count |
            countDictionary at: className put: count + 1
        ] ifAbsent: [
            countDictionary at: className put: 1
        ].
    ].

	"
	countDictionary := Dictionary new.
	countDictionary at: HyperJumpEffect put: 20.
	countDictionary at: BlackHoleEffect put: 20.
	countDictionary at: MoonWalkEffect put: 10.
	"
	^ countDictionary.
]

{ #category : #accessing }
LoadedBoard >> snapToLastTile: aShip [

	(aShip position > tileEffectArray size and: aShip lapsLeft = maxLap)
		ifTrue: [ aShip moveTiles: tileEffectArray size - aShip position ]
]
