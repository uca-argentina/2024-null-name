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
BoardTest >> testBoardHasANumberOfLightYears [

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

	self assert: aBoard numOfLightYears equals: 6
]

{ #category : #tests }
BoardTest >> testBoardHasANumberOfParsecs [

	| aBoard aTileArray aParsecAmount |
	aTileArray := OrderedCollection
		              with: NullEffect new
		              with: NullEffect new
		              with: NullEffect new
		              with: NullEffect new.
	aParsecAmount := Parsec withNominalValue: 2.
	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: aParsecAmount
		          withAmountOfLaps: 3.

	self assert: aBoard numOfParsecs equals: 2
]

{ #category : #tests }
BoardTest >> testBoardHasANumberOfTiles [

	| aBoard aTileArray aParsecAmount |
	
	aTileArray := OrderedCollection new.
	3 timesRepeat: [ aTileArray add: NullEffect new ].
	aParsecAmount := Parsec withNominalValue: 3.
	aBoard := Board
				          withTileEffectCollection: aTileArray
				          withLengthInUnits: aParsecAmount
				          withAmountOfLaps: 1.

	self assert: aBoard numbOfTiles equals: 3
]

{ #category : #tests }
BoardTest >> testWormHoleTilePairsCannotOverlap [

	| aWormHolePair aProbabilityDistributionCollection aTileEffectsCreator |
	aWormHolePair := #( 3 3 ).

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
		withMessage: 'Wormhole tiles cannot be in the same position'
]
