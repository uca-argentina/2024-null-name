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
Board class >> amountOfLapsIsValid: anAmountOfLaps [

	anAmountOfLaps strictlyPositive ifFalse: [
		Error signal: 'Cannot play with less than 1 lap' ]
]

{ #category : #'argument validation' }
Board class >> numberOfTileIsValid: aNumberOfTiles [

	aNumberOfTiles strictlyPositive ifFalse: [
		Error signal: 'Board tiles must be greater than 0' ]
]

{ #category : #'class initialization' }
Board class >> withLengthInTileAndParsec: aPairOfLengths  withWormHolePositions: aWormHolePair withAmountOfLaps: anAmountOfLaps withParsecArray: aParsecArray [

	self numberOfTileIsValid: aPairOfLengths first.
	self wormHolePairIsValid: aWormHolePair with: aPairOfLengths first.
	self amountOfLapsIsValid: anAmountOfLaps.

	^ self new
		  initializeWithLengths: aPairOfLengths
		  withWormHolePositions: aWormHolePair
		  withAmountOfLaps: anAmountOfLaps
		  withParsecArray: aParsecArray asOrderedCollection
]

{ #category : #'argument validation' }
Board class >> wormHolePairIsValid: aWormHolePair with: aNumberOfTiles [

	(aWormHolePair allSatisfy: [ :i |
		 i <= aNumberOfTiles and: i strictlyPositive ]) ifFalse: [
		Error signal: 'Wormhole tiles are out of bounds' ].
	(aWormHolePair anySatisfy: [ :i | i = 1 ]) ifTrue: [
		Error signal: 'Wormhole cannot be created in first tile of board' ].
	aWormHolePair first = aWormHolePair last ifTrue: [
		Error signal: 'Wormhole tiles cannot be in the same position' ]
]

{ #category : #accessing }
Board >> adjustShipPositionBelowOne: aShip [

	(aShip position < 1 and: aShip lapsDone > 1) ifFalse: [ ^ self ].
	aShip moveTiles: tileEffectArray size.
	aShip modifyLap: -1
]

{ #category : #accessing }
Board >> adjustShipPositionOverboard: aShip [

	(aShip position > tileEffectArray size and: aShip lapsDone <= maxLap)
		ifFalse: [ ^ self ].
	aShip moveTiles: tileEffectArray size negated.
	aShip modifyLap: 1
]

{ #category : #modifying }
Board >> applyTileEffectOn: aGame triggeredBy: aShip [

	(tileEffectArray at: aShip position) applyOn: aGame
]

{ #category : #initialization }
Board >> initializeWithLengths: aPairOfLengths withWormHolePositions: aWormHolePair withAmountOfLaps: anAmountOfLaps withParsecArray: aParsecArray [

	| aTileEffectsCreator |
	maxLap := anAmountOfLaps.
	parsecs := aPairOfLengths last.
	tileEffectArray := OrderedCollection new.

	aTileEffectsCreator := TileEffectsCreator new.
	tileEffectArray := aTileEffectsCreator
		                   createWithWormHolePositions: aWormHolePair
		                   withBoardLenghts: aPairOfLengths
		                   withParsecArrry: aParsecArray
]

{ #category : #testing }
Board >> isInLastTile: aShip [

	^ aShip position = 1 and: aShip lapsDone > maxLap
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

	| countDictionary |
	countDictionary := Dictionary new.

	tileEffectArray do: [ :effect |
		| className |
		className := effect class.
		countDictionary
			at: className
			ifPresent: [ :count | countDictionary at: className put: count + 1 ]
			ifAbsent: [ countDictionary at: className put: 1 ] ].

	"
	countDictionary := Dictionary new.
	countDictionary at: HyperJumpEffect put: 20.
	countDictionary at: BlackHoleEffect put: 20.
	countDictionary at: MoonWalkEffect put: 10.
	"
	^ countDictionary
]

{ #category : #accessing }
Board >> snapToFinishTile: aShip [

	aShip lapsDone > maxLap ifTrue: [ aShip moveToFirstTile ]
]
