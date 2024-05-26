Class {
	#name : #ProbabilityEffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ProbabilityEffectTest >> testBanana [

	| aBoard aNumberOfTiles aWormHoleTilePair aNumberOfParsecs aNumberOfLaps |
	aNumberOfTiles := 102.
	aWormHoleTilePair := #( 2 4 ).
	aNumberOfParsecs := 10.
	aNumberOfLaps := 1.

	aBoard := Board
		          withTiles: aNumberOfTiles
		          withWormHolePositions: aWormHoleTilePair
		          withParsecs: aNumberOfParsecs
		          withAmountOfLaps: aNumberOfLaps.

	self assert: (aBoard numberBoxEffect at: MoonWalkEffect ) equals: 10
]

{ #category : #tests }
ProbabilityEffectTest >> testWhenBoardIsCreatedTheAmountOfBlackHoleEffectFollowTheCorrectDistribution [

	| aBoard aNumberOfTiles aWormHoleTilePair aNumberOfParsecs aNumberOfLaps |
	aNumberOfTiles := 102.
	aWormHoleTilePair := #( 2 4 ).
	aNumberOfParsecs := 10.
	aNumberOfLaps := 1.

	aBoard := Board
		          withTiles: aNumberOfTiles
		          withWormHolePositions: aWormHoleTilePair
		          withParsecs: aNumberOfParsecs
		          withAmountOfLaps: aNumberOfLaps.

	self assert: (aBoard numberBoxEffect at: BlackHoleEffect) equals: 20
]

{ #category : #tests }
ProbabilityEffectTest >> testWhenBoardIsCreatedTheAmountOfHyperSpaceJumpEffectFollowTheCorrectDistribution [

	| aBoard aNumberOfTiles aWormHoleTilePair aNumberOfParsecs aNumberOfLaps |
	aNumberOfTiles := 102.
	aWormHoleTilePair := #( 2 4 ).
	aNumberOfParsecs := 10.
	aNumberOfLaps := 1.

	aBoard := Board
		          withTiles: aNumberOfTiles
		          withWormHolePositions: aWormHoleTilePair
		          withParsecs: aNumberOfParsecs
		          withAmountOfLaps: aNumberOfLaps.

	self assert: (aBoard numberBoxEffect at: HyperJumpEffect) equals: 20
]
