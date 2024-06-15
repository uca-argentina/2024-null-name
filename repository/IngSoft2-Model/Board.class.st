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
Board >> adjustShipPosition: aShip [

	(self shouldAdjustShipPosition: aShip) ifFalse: [ ^ self ].

	aShip modifyLap: aShip position - 1 // tileEffectArray size.
	aShip moveTiles: tileEffectArray size
		* (aShip position - 1 // tileEffectArray size) negated
]

{ #category : #'accessing - arguments' }
Board >> allTileEffectsAmount [

	| countDictionary |
	countDictionary := Dictionary new.

	tileEffectArray do: [ :effect |
		countDictionary
			at: effect class
			ifPresent: [ :count |
			countDictionary at: effect class put: count + 1 ]
			ifAbsent: [ countDictionary at: effect class put: 1 ] ].

	^ countDictionary
]

{ #category : #modifying }
Board >> applyTileEffectOn: aGame At: aPosition [

	(tileEffectArray at: aPosition) applyOn: aGame
]

{ #category : #initialization }
Board >> initializeWithLengths: aPairOfLengths withWormHolePositions: aWormHolePair withAmountOfLaps: anAmountOfLaps withParsecArray: aParsecArray [

	| aTileEffectsCreator |
	maxLap := anAmountOfLaps.
	parsecs := aPairOfLengths last.

	aTileEffectsCreator := TileEffectsCreator
		                       createWithWormHolePositions: aWormHolePair
		                       withBoardLenghts: aPairOfLengths
		                       withParsecArray: aParsecArray.

	tileEffectArray := aTileEffectsCreator generateEffectArray
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

{ #category : #accessing }
Board >> shouldAdjustShipPosition: aShip [

	^ (aShip position > tileEffectArray size and:
		   aShip lapsDone <= maxLap) or:
		  (aShip position < 1 and: aShip lapsDone > 1)
]

{ #category : #accessing }
Board >> snapToFinishTile: aShip [

	aShip lapsDone > maxLap ifTrue: [ aShip moveToFirstTile ]
]
