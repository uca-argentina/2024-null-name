Class {
	#name : #BoardInitializationTest,
	#superclass : #BoardTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardInitializationTest >> testBoardCannotBeInitializedWithLessThanOneParsec [

	| aTileArray |
	aTileArray := OrderedCollection
		              with: NullEffect new
		              with: NullEffect new
		              with: NullEffect new
		              with: NullEffect new.
	self
		should: [
			Board
				withTileEffectCollection: aTileArray
				withLengthInUnits: (Parsec withNominalValue: 0)
				withAmountOfLaps: 1 ]
		raise: Error
		withMessage: 'Board size in parsecs must be greater than 0'
]

{ #category : #tests }
BoardInitializationTest >> testBoardCannotBeInitializedWithLessThanOneTile [

	| numTiles aTileArray|
	numTiles := 0.
	
	aTileArray := OrderedCollection new.
	
	
	self
		should: [
			Board
				          withTileEffectCollection: aTileArray
				          withLengthInUnits: 0
				          withAmountOfLaps: 1 ]
		raise: Error
		withMessage: 'Board tiles must be greater than 0'
]

{ #category : #tests }
BoardInitializationTest >> testBoardCannotBeInitializedWithLessThanThreeLightYears [

	| aTileArray |
	aTileArray := OrderedCollection
		              with: NullEffect new
		              with: NullEffect new
		              with: NullEffect new
		              with: NullEffect new.
	self
		should: [
			Board
				withTileEffectCollection: aTileArray
				withLengthInUnits: (LightYear withNominalValue: 2)
				withAmountOfLaps: 1 ]
		raise: Error
		withMessage: 'Not enough LightYears for a single Parsec'
]

{ #category : #tests }
BoardInitializationTest >> testBoardMustHaveAtLeast1Lap [

	| aWormHolePair aTileArray|
	aWormHolePair := #( 3 4 ).
	aTileArray:= OrderedCollection new.
	4 timesRepeat: [ aTileArray add: NullEffect new ].
	
	self
		should: [
			Board
				withTileEffectCollection: aTileArray
				withLengthInUnits: 4
				withAmountOfLaps: 0]
		raise: Error
		withMessage: 'Cannot play with less than 1 lap'
]

{ #category : #tests }
BoardInitializationTest >> testSpecialTilesCannotBeCreatedIfPositionsExceedBoardSize [

	| aWormHolePair aProbabilityDistributionCollection aTileEffectsCreator |
	aWormHolePair := #( 2 6 ).

	aProbabilityDistributionCollection := OrderedCollection with:
		                                      (ProbabilityAssociation
			                                       associate: [ NullEffect ]
			                                       withProbability: 100).
	aTileEffectsCreator := TileEffectsCreator
		                       createWithProbabilityDistribution:
		                       aProbabilityDistributionCollection.
	self
		should: [
			aTileEffectsCreator
				generateRandomBoardWithAmountOfTiles: 3
				withAmountOfParsecs: 3
				withWormHolePair: aWormHolePair
				withHyperJumpArray: #( 1 1 1 )
				withAmountOfLaps: 1 ]
		raise: Error
		withMessage: 'Wormhole tiles are out of bounds'
]

{ #category : #tests }
BoardInitializationTest >> testWhenAssigningALengthInLightYearsParsecsAreCalculatedCorrectly [

	| aBoard aTileArray aLightYearAmount |
	aTileArray := OrderedCollection
		              with: NullEffect new
		              with: NullEffect new
		              with: NullEffect new
		              with: NullEffect new.
	aLightYearAmount := LightYear withNominalValue: 6.
	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: aLightYearAmount
		          withAmountOfLaps: 3.

	self assert: aBoard numOfParsecs equals: 2
]

{ #category : #tests }
BoardInitializationTest >> testWormHoleEffectCannotBeCreatedInFirstTileOfBoard [

	| aWormHolePair aProbabilityDistributionCollection aTileEffectsCreator |
	aWormHolePair := #( 1 3 ).
	aProbabilityDistributionCollection := OrderedCollection with:
		                                      (ProbabilityAssociation
			                                       associate: [ NullEffect ]
			                                       withProbability: 100).

	aTileEffectsCreator := TileEffectsCreator
		                       createWithProbabilityDistribution:
		                       aProbabilityDistributionCollection.
	self
		should: [
			aTileEffectsCreator
				generateRandomBoardWithAmountOfTiles: 3
				withAmountOfParsecs: 3
				withWormHolePair: aWormHolePair
				withHyperJumpArray: #( 1 1 1 )
				withAmountOfLaps: 1 ]
		raise: Error
		withMessage: 'Wormhole cannot be created in first tile of board'
]
