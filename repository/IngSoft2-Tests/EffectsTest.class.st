Class {
	#name : #EffectsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
EffectsTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: aErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
EffectsTest >> testBlackHoleEffectCannotBeAplliedAfterGameIsFinished [

	| aBoard aShipName aGame aTileArray|
	
	
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].
	aTileArray at: 2 put: BlackHoleEffect new.
	
	aBoard := Board
				          withTileEffectCollection: aTileArray
				          withLengthInUnits: (Parsec withNominalValue: 10)
				          withAmountOfLaps: 1.
	

	aShipName := OrderedCollection with: 'Juan'.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aShipName
		         withDice: (Dice with:
				          (OrderedCollection with:
					           (SequenceDie withSequence: #( 11 )))).

	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 1 2 ) asOrderedCollection
]

{ #category : #tests }
EffectsTest >> testMoonWalkDistanceCannotBeSmallerThanZero [
	
	self should: [ MoonWalkEffect withMoonwalkDistance: -3 ] raise: Error withMessage: 'Moonwalk distance must be strictly positive'
	
	
]

{ #category : #tests }
EffectsTest >> testWhenApplying2DifferentHyperJumpEffectsShipsMoveTheBiggestAmountOfParsecsInArray [

	| aBoard aShipName aGame aParsecArray aWormHolePair aProbabilityDistributionCollection aTileEffectsCreator |
	aParsecArray := OrderedCollection
		                with: (Parsec withNominalValue: 3)
		                with: (Parsec withNominalValue: 5)
		                with: (Parsec withNominalValue: 1).

	aWormHolePair := #( 101 102 ).

	aProbabilityDistributionCollection := OrderedCollection
		                                      with:
		                                      (ProbabilityAssociation
			                                       associate: [ NullEffect ]
			                                       withProbability: 40)
		                                      with: (ProbabilityAssociation
				                                       associate: [
				                                       BlackHoleEffect ]
				                                       withProbability: 20)
		                                      with: (ProbabilityAssociation
				                                       associate: [
				                                       HyperSpaceJumpEffect ]
				                                       withProbability: 20)
		                                      with: (ProbabilityAssociation
				                                       associate: [
				                                       MoonWalkEffect ]
				                                       withProbability: 10)
		                                      with: (ProbabilityAssociation
				                                       associate: [
				                                       HyperJumpEffect ]
				                                       withProbability: 8)
		                                      with: (ProbabilityAssociation
				                                       associate: [
				                                       AtomicBombEffect ]
				                                       withProbability: 2).
	aTileEffectsCreator := TileEffectsCreator
		                       createWithProbabilityDistribution:
		                       aProbabilityDistributionCollection.

	aBoard := aTileEffectsCreator
		          generateLoadedBoardWithAmountOfTiles: 102
		          withAmountOfParsecs: 102
		          withWormHolePair: aWormHolePair
		          withHyperJumpArray: aParsecArray
		          withAmountOfLaps: 1
		          withCardProbabilities:
		          (ProbabilityAssociation
			           associate: NullCard
			           withProbability: 100).

	aShipName := OrderedCollection with: 'Juan' with: 'Pedro'.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aShipName
		         withDice: (Dice with:
				          (OrderedCollection with:
					           (SequenceDie withSequence: #( 91 92 )))).

	aGame playTurn.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 97 1 ) asOrderedCollection.
	self
		assert: (aGame allShipsPosition at: 'Pedro')
		equals: #( 98 1 ) asOrderedCollection
]

{ #category : #tests }
EffectsTest >> testWhenApplyingAtomicBombEffectAllShipsMoveBackToFirstTileOfTheirCurrentLap [

	| aBoard aShipName aGame aTileArray |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].
	aTileArray at: 7 put: AtomicBombEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 2.

	aShipName := OrderedCollection
		             with: 'Juan'
		             with: 'Pedro'
		             with: 'Jose'.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aShipName
		         withDice: (Dice with:
				          (OrderedCollection with:
					           (SequenceDie withSequence: #( 3 2 10 )))).
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 1 1 ) asOrderedCollection.
	self
		assert: (aGame allShipsPosition at: 'Pedro')
		equals: #( 1 1 ) asOrderedCollection.
	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 1 2 ) asOrderedCollection
]

{ #category : #tests }
EffectsTest >> testWhenApplyingBlackHoleEffectShipMoves4SpacesBack [

	| aBoard aShipName aGame aTileArray |
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].
	aTileArray at: 8 put: BlackHoleEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 16)
		          withAmountOfLaps: 1.



	aShipName := OrderedCollection with: 'Juan'.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aShipName
		         withDice: (Dice with:
				          (OrderedCollection with:
					           (SequenceDie withSequence: #( 7 )))).

	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 4 1 ) asOrderedCollection
]

{ #category : #tests }
EffectsTest >> testWhenApplyingBlackHoleShipNotOnLap1CanMoveBelowFirstTilePosition [

	| aBoard aShipName aGame aTileArray |
	
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].
	aTileArray at: 3 put: BlackHoleEffect new.
	
	aBoard := Board
				          withTileEffectCollection: aTileArray
				          withLengthInUnits: (Parsec withNominalValue: 16)
				          withAmountOfLaps: 2.
	

	aShipName := OrderedCollection with: 'Juan'.

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aShipName
		         withDice: (Dice with:
				          (OrderedCollection with:
					           (SequenceDie withSequence: #( 10 2 )))).

	aGame playTurn.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 9 1 ) asOrderedCollection
]

{ #category : #tests }
EffectsTest >> testWhenApplyingHyperJumpEffectShipCanMoveAVariableAmountOfLightYears [

	| aBoard aShipName aGame aLightYearAndParsecArray aTileArray |
	aLightYearAndParsecArray := OrderedCollection
		                            with: (LightYear withNominalValue: 12)
		                            with: (LightYear withNominalValue: 9)
		                            with: (LightYear withNominalValue: 15)
		                            with: (LightYear withNominalValue: 3).

	aTileArray := OrderedCollection new.
	20 timesRepeat: [ aTileArray add: NullEffect new ].
	aTileArray at: 3 put: (HyperJumpEffect
			 withParsecArray: aLightYearAndParsecArray
			 andLengthInTiles: 20
			 andLengthInParsecs: 10).

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.


	aShipName := OrderedCollection with: 'Juan'.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aShipName
		         withDice: (Dice with:
				          (OrderedCollection with:
					           (SequenceDie withSequence: #( 2 )))).

	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 13 1 ) asOrderedCollection
]

{ #category : #tests }
EffectsTest >> testWhenApplyingHyperJumpEffectShipMovesAVariableParsecDistance [

	| aBoard aShipName aGame aParsecArray aTileArray |
	aParsecArray := #( 4 3 5 1 ).

	aParsecArray := OrderedCollection
		                with: (Parsec withNominalValue: 4)
		                with: (Parsec withNominalValue: 3)
		                with: (Parsec withNominalValue: 5)
		                with: (Parsec withNominalValue: 1).

	aTileArray := OrderedCollection new.
	20 timesRepeat: [ aTileArray add: NullEffect new ].
	aTileArray at: 3 put: (HyperJumpEffect
			 withParsecArray: aParsecArray
			 andLengthInTiles: 20
			 andLengthInParsecs: 10).

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.


	aShipName := OrderedCollection with: 'Juan'.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aShipName
		         withDice: (Dice with:
				          (OrderedCollection with:
					           (SequenceDie withSequence: #( 2 )))).

	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 13 1 ) asOrderedCollection
]

{ #category : #tests }
EffectsTest >> testWhenApplyingHyperJumpEffectShipOnlyMoveWholeDistances [

	| aBoard aShipName aGame aLightYearAndParsecArray aTileArray |
	aLightYearAndParsecArray := OrderedCollection
		                            with: (LightYear withNominalValue: 10)
		                            with: (Parsec withNominalValue: 2)
		                            with: (LightYear withNominalValue: 8)
		                            with: (Parsec withNominalValue: 1).

	aTileArray := OrderedCollection new.
	20 timesRepeat: [ aTileArray add: NullEffect new ].
	aTileArray at: 3 put: (HyperJumpEffect
			 withParsecArray: aLightYearAndParsecArray
			 andLengthInTiles: 20
			 andLengthInParsecs: 10).

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.


	aShipName := OrderedCollection with: 'Juan'.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aShipName
		         withDice: (Dice with:
				          (OrderedCollection with:
					           (SequenceDie withSequence: #( 2 )))).

	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 9 1 ) asOrderedCollection
]

{ #category : #tests }
EffectsTest >> testWhenApplyingHyperJumpRepeatedlyThenDistanceMovedChanges [

	| aBoard aShipName aTileArray aGame aParsecArray |
	aParsecArray := OrderedCollection
		                with: (Parsec withNominalValue: 2)
		                with: (Parsec withNominalValue: 1)
		                with: (Parsec withNominalValue: -1)
		                with: (Parsec withNominalValue: -2).

	aTileArray := OrderedCollection new.
	20 timesRepeat: [ aTileArray add: NullEffect new ].
	aTileArray at: 4 put: (HyperJumpEffect
			 withParsecArray: aParsecArray
			 andLengthInTiles: 20
			 andLengthInParsecs: 10).

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.

	aShipName := OrderedCollection
		             with: 'Juan'
		             with: 'Fran'
		             with: 'Jorge'.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aShipName
		         withDice: (Dice with:
				          (OrderedCollection with:
					           (SequenceDie withSequence: #( 3 )))).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 8 1 ) asOrderedCollection.
	self
		assert: (aGame allShipsPosition at: 'Fran')
		equals: #( 6 1 ) asOrderedCollection.
	self
		assert: (aGame allShipsPosition at: 'Jorge')
		equals: #( 2 1 ) asOrderedCollection
]

{ #category : #tests }
EffectsTest >> testWhenApplyingHyperSpaceJumpEffectShipLosesAShield [

	| aBoard aShipName aTileArray aGame |
	
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].
	aTileArray at: 4 put: HyperSpaceJumpEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 1.

	aShipName := OrderedCollection with: 'Juan'.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aShipName
		         withDice: (Dice with:
				          (OrderedCollection with:
					           (SequenceDie withSequence: #( 3 )))).

	aGame playTurn.

	self assert: (aGame allShipAmountOfShields at: 'Juan') equals: 2
]

{ #category : #tests }
EffectsTest >> testWhenApplyingHyperSpaceJumpEffectShipMoves4SpacesForward [

	| aBoard aShipName aTileArray aGame |
	
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].
	aTileArray at: 4 put: HyperSpaceJumpEffect new.

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 2.

	aShipName := OrderedCollection with: 'Juan'.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aShipName
		         withDice: (Dice with:
				          (OrderedCollection with:
					           (SequenceDie withSequence: #( 3 )))).

	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 8 1 ) asOrderedCollection
]

{ #category : #tests }
EffectsTest >> testWhenApplyingMoonWalkEffectAllShipsButTriggeringShipMoveAVariableDistance [

	| aBoard aShipName aGame aTileArray |

	aTileArray := OrderedCollection new.
	20 timesRepeat: [ aTileArray add: NullEffect new ].
	aTileArray at: 13 put: (MoonWalkEffect withMoonwalkDistance: 3).

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 20)
		          withAmountOfLaps: 2.

	aShipName := OrderedCollection with: 'Juan' with: 'Pedro'.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aShipName
		         withDice: (Dice with:
				          (OrderedCollection with:
					           (SequenceDie withSequence: #( 6 7 )))).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.


	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 13 1 ) asOrderedCollection.
	self
		assert: (aGame allShipsPosition at: 'Pedro')
		equals: #( 5 1 ) asOrderedCollection
]

{ #category : #tests }
EffectsTest >> testWhenApplyingMoonWalkEffectShipLapsBehaveCorrectly [

	| aBoard aShipName aGame aTileArray|
	
	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].
	aTileArray at: 5 put: (MoonWalkEffect withMoonwalkDistance: 3).

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 10)
		          withAmountOfLaps: 3.
	
	aShipName := OrderedCollection
		             with: 'Juan'
		             with: 'Pedro'
		             with: 'Jose'.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aShipName
		         withDice: (Dice with:
				          (OrderedCollection with:
					           (SequenceDie withSequence: #( 6 7 1 )))).

	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.


	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 10 1 ) asOrderedCollection.
	self
		assert: (aGame allShipsPosition at: 'Pedro')
		equals: #( 5 2 ) asOrderedCollection.
	self
		assert: (aGame allShipsPosition at: 'Jose')
		equals: #( 1 1 ) asOrderedCollection
]

{ #category : #tests }
EffectsTest >> testWhenApplyingWormholeEffectOnShipMoveAccordingly [

	| aGame aBoard aWormHolePair aShipName aTileArray |
	aWormHolePair := #( 2 5 ).

	aTileArray := OrderedCollection new.
	10 timesRepeat: [ aTileArray add: NullEffect new ].
	aTileArray
		at: 2
		put: (WormholeEffect  fromPosition: 2 toPosition: 5).
	aTileArray
		at: 5
		put: (WormholeEffect fromPosition: 5 toPosition: 2).

	aBoard := Board
		          withTileEffectCollection: aTileArray
		          withLengthInUnits: (Parsec withNominalValue: 6)
		          withAmountOfLaps: 3.

	aShipName := OrderedCollection with: 'Juan'.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aShipName
		         withDice: (Dice with:
				          (OrderedCollection with:
					           (SequenceDie withSequence: #( 1 )))).

	aGame playTurn.

	self
		assert: (aGame allShipsPosition at: 'Juan')
		equals: #( 5 1 ) asOrderedCollection
]
