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
BoardTest >> testBoardHasANumberOfParsecs [

	| aBoard aTileArray |
	aTileArray := OrderedCollection
		              with: NullEffect new
		              with: NullEffect new
		              with: NullEffect new
		              with: NullEffect new.
	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInParsecs: 2
		          withAmountOfLaps: 3.

	self assert: aBoard numOfParsecs equals: 2
]

{ #category : #tests }
BoardTest >> testBoardHasANumberOfTiles [

	| aBoard aTileArray|
	
	aTileArray := OrderedCollection new.
	3 timesRepeat: [ aTileArray add: NullEffect new ].
	
	aBoard := Board
				          withTileEffectCollection: aTileArray
				          withLengthInParsecs: 3
				          withAmountOfLaps: 1.

	self assert: aBoard numbOfTiles equals: 3
]

{ #category : #tests }
BoardTest >> testWormHoleTilePairsCannotOverlap [

	| aWormHolePair aProbabilityDistributionCollection aTileEffectsCreator |
	aWormHolePair := #( 3 3 ).

	aProbabilityDistributionCollection := OrderedCollection with:
		                                      (EffectProbability
			                                       effect: [ NullEffect ]
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
				withParsecArray: #( 1 1 1 )
				withAmountOfLaps: 1 ]
		raise: Error
		withMessage: 'Wormhole tiles cannot be in the same position'
]
