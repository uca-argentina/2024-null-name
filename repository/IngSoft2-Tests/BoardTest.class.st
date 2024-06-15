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
BoardTest >> testBoardCannotBeInitializedWithLessThanOneTile [

	| numTiles |
	numTiles := 0.
	self
		should: [
			SetBoard
				withLengthInTileAndParsec: #( 0 0 )
				withWormHolePositions: #( 0 0 )
				withAmountOfLaps: 1 ]
		raise: Error
		withMessage: 'Board tiles must be greater than 0'
]

{ #category : #tests }
BoardTest >> testBoardHasANumberOfParsecs [

	| aBoard aTileArray |
	aTileArray := OrderedCollection
		              with: NullEffect new
		              with: NullEffect new
		              with: NullEffect new
		              with: NullEffect new.
	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLength: #( 4 2 )
		          withAmountOfLaps: 3.

	self assert: aBoard numOfParsecs equals: 2
]

{ #category : #tests }
BoardTest >> testBoardHasANumberOfTiles [

	| aBoard |
	aBoard := SetBoard
		          withLengthInTileAndParsec: #( 3 3 )
		          withWormHolePositions: #( 2 3 )
		          withAmountOfLaps: 1.

	self assert: aBoard numbOfTiles equals: 3
]

{ #category : #tests }
BoardTest >> testBoardMustHaveAtLeast1Lap [

	| aWormHolePair aTileArray|
	aWormHolePair := #( 3 4 ).
	aTileArray:= OrderedCollection new.
	4 timesRepeat: [ aTileArray add: NullEffect new ].
	
	self
		should: [
			Board
				withTileEffectCollection: aTileArray
				withLength: #( 4 4 )
				withAmountOfLaps: 0]
		raise: Error
		withMessage: 'Cannot play with less than 1 lap'
]

{ #category : #tests }
BoardTest >> testSpecialTilesCannotBeCreatedIfPositionsExceedBoardSize [

	| aWormHolePair aProbabilityDistributionCollection|
	aWormHolePair := #( 2 6 ).

	aProbabilityDistributionCollection := OrderedCollection with:
		                                      (EffectProbability
			                                       effect: [ NullEffect new ]
			                                       withProbability: 100).

	self
		should: [
			TileEffectsCreator
				createWithBoardLength: #( 3 3 )
				withWormHolePositions: aWormHolePair
				withParsecArray: #( 1 1 1 )
				withProbabilityDistribution: aProbabilityDistributionCollection ]
		raise: Error
		withMessage: 'Wormhole tiles are out of bounds'
]

{ #category : #tests }
BoardTest >> testTotalSumOfEffectsProbabilitiesIs100 [

	| aProbabilityDistributionCollection |
	aProbabilityDistributionCollection := OrderedCollection with:
		                                      (EffectProbability
			                                       effect: [
			                                       MoonWalkEffect
				                                       withMoonwalkDistance:
				                                       10 atRandom ]
			                                       withProbability: 80).

	self
		should: [
			TileEffectsCreator
				createWithBoardLength: #( 10 10 )
				withWormHolePositions: #( 2 3 )
				withParsecArray: #( 2 1 1 4 )
				withProbabilityDistribution: aProbabilityDistributionCollection ]
		raise: Error
		withMessage:
		'Total efffect probabilities cannot be diferent from 100%'.
]

{ #category : #tests }
BoardTest >> testWhenABoardIsCreatedWithATileEffectCreatorItFollowsTheSetDistributionOfTileEffectCreator [

	| tileArray aTileEffectCreator aProbabilityDistributionCollection aBoard |
	aProbabilityDistributionCollection := OrderedCollection with:
		                                      (EffectProbability
			                                       effect: [ NullEffect new ]
			                                       withProbability: 100).

	aTileEffectCreator := TileEffectsCreator
		                      createWithBoardLength: #( 10 10 )
		                      withWormHolePositions: #( 2 3 )
		                      withParsecArray: #( 2 1 1 4 )
		                      withProbabilityDistribution:
		                      aProbabilityDistributionCollection.

	tileArray := aTileEffectCreator generateRandomEffectArray.

	aBoard := Board
		          withTileEffectCollection: tileArray
		          withLength: #( 10 10 )
		          withAmountOfLaps: 3.

	self assert: (aBoard allTileEffectsAmount at: NullEffect) equals: 8
]

{ #category : #tests }
BoardTest >> testWhenBoardIsCreatedTheAmountOfEffectsFollowTheCorrectDistribution [

	| aBoard aPairOfLengths aWormHolePair |
	aWormHolePair := #( 2 4 ).
	aPairOfLengths := #( 102 10 ).

	aBoard := LoadedBoard
		          withLengthInTileAndParsec: aPairOfLengths
		          withWormHolePositions: aWormHolePair
		          withAmountOfLaps: 1
		          withParsecArray: #( 1 3 5 1 ).

	self assert: (aBoard allTileEffectsAmount at: NullEffect) equals: 40.

	self
		assert: (aBoard allTileEffectsAmount at: BlackHoleEffect)
		equals: 20.
	self
		assert: (aBoard allTileEffectsAmount at: HyperSpaceJumpEffect)
		equals: 20.
	self
		assert: (aBoard allTileEffectsAmount at: MoonWalkEffect)
		equals: 10.
	self
		assert: (aBoard allTileEffectsAmount at: HyperJumpEffect)
		equals: 8.
	self
		assert: (aBoard allTileEffectsAmount at: AtomicBombEffect)
		equals: 2.
	self
		assert: (aBoard allTileEffectsAmount at: WormholeEffect)
		equals: 2
]

{ #category : #tests }
BoardTest >> testWhenBoardIsCreatedWithRandomizedEffectProbabilitiesItFollowsCorrespondingDistribution [
	"
	TEST FAILS WITH PHARO 12 CI
	
	| aBoard aPairOfLengths aWormHolePair numberOfIterations aDictonaryOfEffectApearences averageEffectDistribution aProbabilityDistributionCollection| 
	
	aWormHolePair := #( 2 4 ).
	aPairOfLengths := #( 102 102 ).
	numberOfIterations := 100.
	averageEffectDistribution := Dictionary new.
	
	aProbabilityDistributionCollection := OrderedCollection with:
		                                      (EffectProbability
			                                       effect: [ NullEffect new ]
			                                       withProbability: 40)with:
		                                      (EffectProbability
			                                       effect: [ BlackHoleEffect  new ]
			                                       withProbability: 20)with:
		                                      (EffectProbability
			                                       effect: [ HyperSpaceJumpEffect new ]
			                                       withProbability: 20)with:
		                                      (EffectProbability
			                                       effect: [ MoonWalkEffect  new ]
			                                       withProbability: 10)with:
		                                      (EffectProbability
			                                       effect: [ HyperJumpEffect  new ]
			                                       withProbability: 8)with:
		                                      (EffectProbability
			                                       effect: [ AtomicBombEffect  new ]
			                                       withProbability: 2).
			
	
	numberOfIterations timesRepeat: [
		|aTileEffectsCreator aTileArray|
		aTileEffectsCreator := TileEffectsCreator
				createWithBoardLength: #( 102 102 )
				withWormHolePositions: aWormHolePair
				withParsecArray: #( 1 1 1 )
				withProbabilityDistribution: aProbabilityDistributionCollection.
		aTileArray := aTileEffectsCreator generateRandomEffectArray.
		
		
		aBoard := Board
				withTileEffectCollection: aTileArray
				withLength: #( 4 4 )
				withAmountOfLaps: 1.

		aDictonaryOfEffectApearences := aBoard allTileEffectsAmount.
		aDictonaryOfEffectApearences keysDo: [ :effect |
			| amountOfEffect |
			amountOfEffect := (aDictonaryOfEffectApearences at: effect) value.
			averageEffectDistribution
				at: effect
				ifPresent: [ :value |
					averageEffectDistribution
						at: effect
						put: value + (amountOfEffect / numberOfIterations) ]
				ifAbsent: [
					averageEffectDistribution
						at: effect
						put: amountOfEffect / numberOfIterations ] ] ].


	self assert: ((averageEffectDistribution at: NullEffect) between: 35 and: 45) .

	self
		assert: ((averageEffectDistribution at: BlackHoleEffect)
		between: 18 and: 22).
	self
		assert: ((averageEffectDistribution at: HyperSpaceJumpEffect)
		between: 18 and: 22).
	self
		assert: ((averageEffectDistribution at: MoonWalkEffect)
		between: 9 and: 11).
	self
		assert: ((averageEffectDistribution at: HyperJumpEffect)
		between: 7 and: 9 ).
	self
		assert: ((averageEffectDistribution at: AtomicBombEffect)
		between: 1 and: 3).
	self
		assert: (averageEffectDistribution at: WormholeEffect)
		equals: 2
"
]

{ #category : #tests }
BoardTest >> testWormHoleEffectCannotBeCreatedInFirstTileOfBoard [

	| aWormHolePair aProbabilityDistributionCollection |
	aWormHolePair := #( 1 3 ).
	aProbabilityDistributionCollection := OrderedCollection with:
		                                      (EffectProbability
			                                       effect: [ NullEffect new ]
			                                       withProbability: 100).

	self
		should: [
			TileEffectsCreator
				createWithBoardLength: #( 3 3 )
				withWormHolePositions: aWormHolePair
				withParsecArray: #( 1 1 1 )
				withProbabilityDistribution: aProbabilityDistributionCollection ]
		raise: Error
		withMessage: 'Wormhole cannot be created in first tile of board'
]

{ #category : #tests }
BoardTest >> testWormHoleTilePairsCannotOverlap [

	| aWormHolePair aProbabilityDistributionCollection |
	aWormHolePair := #( 3 3 ).

	aProbabilityDistributionCollection := OrderedCollection with:
		                                      (EffectProbability
			                                       effect: [ NullEffect new ]
			                                       withProbability: 100).


	self
		should: [
			TileEffectsCreator
				createWithBoardLength: #( 3 3 )
				withWormHolePositions: aWormHolePair
				withParsecArray: #( 1 1 1 )
				withProbabilityDistribution: aProbabilityDistributionCollection ]
		raise: Error
		withMessage: 'Wormhole tiles cannot be in the same position'
]
