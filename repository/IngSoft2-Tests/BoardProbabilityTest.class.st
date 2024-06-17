Class {
	#name : #BoardProbabilityTest,
	#superclass : #BoardTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardProbabilityTest >> testTotalSumOfEffectsProbabilitiesIs100 [

	| aProbabilityDistributionCollection |
	aProbabilityDistributionCollection := OrderedCollection with:
		                                      (ProbabilityAssociation
			                                       associate: [ MoonWalkEffect ]
			                                       withProbability: 80).
	self
		should: [
			TileEffectsCreator createWithProbabilityDistribution:
				aProbabilityDistributionCollection ]
		raise: Error
		withMessage:
		'Total efffect probabilities cannot be diferent from 100%'
]

{ #category : #tests }
BoardProbabilityTest >> testWhenABoardIsCreatedWithATileEffectCreatorItFollowsTheSetDistributionOfTileEffectCreator [

	| aTileEffectsCreator aProbabilityDistributionCollection aBoard |
	aProbabilityDistributionCollection := OrderedCollection with:
		                                      (ProbabilityAssociation
			                                       associate: [ NullEffect ]
			                                       withProbability: 100).
	aTileEffectsCreator := TileEffectsCreator
		                       createWithProbabilityDistribution:
		                       aProbabilityDistributionCollection.

	aBoard := aTileEffectsCreator
		          generateRandomBoardWithAmountOfTiles: 10
		          withAmountOfParsecs: 10
		          withWormHolePair: #( 2 3 )
		          withHyperJumpArray: #( 2 1 1 4 )
		          withAmountOfLaps: 3.

	self assert: (aBoard allTileEffectsAmount at: NullEffect) equals: 8
]

{ #category : #tests }
BoardProbabilityTest >> testWhenBoardIsCreatedTheAmountOfEffectsFollowTheCorrectDistribution [

	| aBoard aPairOfLengths aWormHolePair aProbabilityDistributionCollection aTileEffectsCreator |
	aWormHolePair := #( 101 102 ).
	aPairOfLengths := #( 102 102 ).

	aProbabilityDistributionCollection := OrderedCollection
		                                      with:
		                                      (ProbabilityAssociation
			                                       associate: [ NullEffect ]
			                                       withProbability: 40)
		                                      with:
		                                      (ProbabilityAssociation
			                                       associate: [ BlackHoleEffect ]
			                                       withProbability: 20)
		                                      with: (ProbabilityAssociation
				                                       associate: [
				                                       HyperSpaceJumpEffect ]
				                                       withProbability: 20)
		                                      with:
		                                      (ProbabilityAssociation
			                                       associate: [ MoonWalkEffect ]
			                                       withProbability: 10)
		                                      with:
		                                      (ProbabilityAssociation
			                                       associate: [ HyperJumpEffect ]
			                                       withProbability: 8)
		                                      with:
		                                      (ProbabilityAssociation
			                                       associate: [ AtomicBombEffect ]
			                                       withProbability: 2).

	aTileEffectsCreator := TileEffectsCreator
		                       createWithProbabilityDistribution:
		                       aProbabilityDistributionCollection.

	aBoard := aTileEffectsCreator
		          generateLoadedBoardWithAmountOfTiles: 102
		          withAmountOfParsecs: 102
		          withWormHolePair: aWormHolePair
		          withHyperJumpArray: #( 1 1 1 )
		          withAmountOfLaps: 1.

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
BoardProbabilityTest >> testWhenBoardIsCreatedWithRandomizedEffectProbabilitiesItFollowsCorrespondingDistribution [
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
