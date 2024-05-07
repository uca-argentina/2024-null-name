Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BoardTest >> should: anErrorBlock raise: exceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: exceptionClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
BoardTest >> testBoardAppliesEffectWhenShipFallsOnSpecialTile [
| aBoard aWormholePositons aShip |
aWormholePositons := #(2 5).
aBoard:=Board withTiles: 6 withWormHolePositions: aWormholePositons.
aShip:= Ship createWithName: 'Juan'.
aShip moveTiles: 1.

aBoard tileEffectOn: aShip.
self assert: (aShip givePosition) equals: 5.
]

{ #category : #tests }
BoardTest >> testBoardCanAssignSpecialTilesInCreation [

| aBoard aWormholePositons |
aWormholePositons := #(2 5).
aBoard:=Board withTiles: 6 withWormHolePositions: aWormholePositons.

self assert: (((aBoard tileInPosition: 2) getEffect) isMemberOf: WormholeEffect).
self assert: (((aBoard tileInPosition: 5) getEffect) isMemberOf: WormholeEffect).
]

{ #category : #tests }
BoardTest >> testBoardCannotBeInitializedWithLessThanOneTile [

	| numTiles |
	numTiles := 0.
	self
		should: [ Board withTiles: numTiles ]
		raise: Error
		withMessage: 'Board tiles must be greater than 0'
]

{ #category : #tests }
BoardTest >> testBoardHasANumberOfTiles [

| numTiles aBoard |
numTiles :=3.
aBoard := Board withTiles:numTiles .

self assert: aBoard numbOfTiles equals: 3
]

{ #category : #tests }
BoardTest >> testIfShipMovesOverBoardBoundsThenSnapBackToLastTile [
| aBoard aShip |
aBoard:=Board withTiles: 6.
aShip:= Ship createWithName: 'Juan'.
aShip moveTiles: 7.
aBoard checkPositionOf: aShip.
self assert: (aShip givePosition) equals: 6.
]

{ #category : #tests }
BoardTest >> testSpecialTilesCannotBeCreatedIfPositionsExceedBoardSize [

| aWormholePositons  |
aWormholePositons := #(2 6).

self should: [Board withTiles: 3 withWormHolePositions: aWormholePositons]
        raise: Error
        withMessage: 'Wormhole tiles are out of bounds'.
]
