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
LoadedBoard class >> withLengthInTileAndParsec: aPairOfLengths  withWormHolePositions: aWormHoleTilePair withAmountOfLaps: anAmountOfLaps withParsecArray: aParsecArray [

	self numberOfTileIsValid: aPairOfLengths first.
	self wormHolePairIsValid: aWormHoleTilePair with: aPairOfLengths first.

	^ self new
		  initializeWithLengths: aPairOfLengths
		  withWormHolePositions: aWormHoleTilePair
		  withAmountOfLaps: anAmountOfLaps
		  withParsecArray: aParsecArray asOrderedCollection 
]

{ #category : #'argument validation' }
LoadedBoard class >> wormHolePairIsValid: aWormHoleTilePair with: aNumberOfTiles [

	(aWormHoleTilePair allSatisfy: [ :i |
		 i <= aNumberOfTiles and: i strictlyPositive ]) ifFalse: [
		Error signal: 'Wormhole tiles are out of bounds' ].
	(aWormHoleTilePair anySatisfy: [ :i | i = 1 ]) ifTrue: [
		Error signal: 'Wormhole cannot be created in first tile of board' ].
	aWormHoleTilePair first = aWormHoleTilePair last ifTrue: [
		Error signal: 'Wormhole tiles cannot be in the same position' ]
]

{ #category : #accessing }
LoadedBoard >> adjustShipPositionBelowOne: aShip [

	(aShip position < 1 and: aShip lapsDone > 1) ifFalse: [ ^ self ].
	aShip moveTiles: tileEffectArray size.
	aShip modifyLap: -1
]

{ #category : #accessing }
LoadedBoard >> adjustShipPositionOverboard: aShip [

	(aShip position > tileEffectArray size and: aShip lapsDone <= maxLap)
		ifFalse: [ ^ self ].
	aShip moveTiles: tileEffectArray size negated.
	aShip modifyLap: 1
]

{ #category : #modifying }
LoadedBoard >> applyTileEffectOn: aGame triggeredBy: aShip [

	(tileEffectArray at: aShip position) applyOn: aGame
]

{ #category : #initialization }
LoadedBoard >> initializeWithLengths: aPairOfLengths withWormHolePositions: aWormHoleTilePair withAmountOfLaps: anAmountOfLaps withParsecArray: aParsecArray [

	|  aTileEffectsCreator |
	maxLap := anAmountOfLaps.
	tileEffectArray := OrderedCollection new.
	parsecs := aPairOfLengths last.

	aTileEffectsCreator := LoadedTileEffectsCreator new.

	tileEffectArray := aTileEffectsCreator
		                   createWithWormHolePositions: aWormHoleTilePair
		                   withBoardLenghts: aPairOfLengths
		                   withParsecArrry: aParsecArray
]

{ #category : #testing }
LoadedBoard >> isInLastTile: aShip [

	^ aShip position = 1 and: aShip lapsDone > maxLap
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
LoadedBoard >> snapToFinishTile: aShip [

	(aShip lapsDone > maxLap)
		ifTrue: [ aShip moveToFirstTile ]
]
