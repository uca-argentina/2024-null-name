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

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 2 put: BlackHoleEffect new;
		                        yourself.
	aBoard := SetBoard
		          withLengthInTileAndParsec: #( 10 10 )
		          withWormHolePositions: #( 2 4 )
		          withAmountOfLaps: 1
		          withEffectsInPosition: aDictionaryOfEffects.

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

	| aBoard aShipName aGame aParsecArray |
	aParsecArray := #( 3 5 1 ).

	aBoard := LoadedBoard
		          withLengthInTileAndParsec: #( 102 102 )
		          withWormHolePositions: #( 2 5 )
		          withAmountOfLaps: 1
		          withParsecArray: aParsecArray.

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

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 7 put: AtomicBombEffect new;
		                        yourself.

	aBoard := SetBoard
		          withLengthInTileAndParsec: #( 10 10 )
		          withWormHolePositions: #( 2 5 )
		          withAmountOfLaps: 2
		          withEffectsInPosition: aDictionaryOfEffects.

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

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 8 put: BlackHoleEffect new;
		                        yourself.

	aBoard := SetBoard
		          withLengthInTileAndParsec: #( 10 10 )
		          withWormHolePositions: #( 2 5 )
		          withAmountOfLaps: 1
		          withEffectsInPosition: aDictionaryOfEffects.

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

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 3 put: BlackHoleEffect new;
		                        yourself.
	aBoard := SetBoard
		          withLengthInTileAndParsec: #( 10 10 )
		          withWormHolePositions: #( 2 4 )
		          withAmountOfLaps: 3
		          withEffectsInPosition: aDictionaryOfEffects.

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
EffectsTest >> testWhenApplyingHyperJumpEffectShipMovesAVariableParsecDistance [

	| aBoard aShipName aDictionaryOfEffects aGame aDic aParsecArray |
	aParsecArray := #( 4 3 5 1 ).
	aDic := Dictionary newFrom: {
			        ('Tiles' -> 20).
			        ('Parsecs' -> 10) }.

	aDictionaryOfEffects := Dictionary new
		                        at: 3
		                        put:
			                        (HyperJumpEffect
				                         withParsecArray: aParsecArray
				                         andBoardLengths: aDic);
		                        yourself.

	aBoard := SetBoard
		          withLengthInTileAndParsec: #( 20 10 )
		          withWormHolePositions: #( 2 5 )
		          withAmountOfLaps: 1
		          withEffectsInPosition: aDictionaryOfEffects.

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
EffectsTest >> testWhenApplyingHyperJumpRepeatedlyThenDistanceMovedChanges [

	| aBoard aShipName aDictionaryOfEffects aGame aParsecArray aDic|
	aParsecArray := #( 2 1 -1 -2).
	aDic := Dictionary newFrom: {
			        ('Tiles' -> 20).
			        ('Parsecs' -> 10) }.

	aDictionaryOfEffects := Dictionary new
		                        at: 4
		                        put:
			                        (HyperJumpEffect
				                         withParsecArray: aParsecArray
				                         andBoardLengths: aDic);
		                        yourself.
	aBoard := SetBoard
		          withLengthInTileAndParsec: #( 20 10 )
		          withWormHolePositions: #( 2 5 )
		          withAmountOfLaps: 1
		          withEffectsInPosition: aDictionaryOfEffects.

	aShipName := OrderedCollection with: 'Juan' with: 'Fran' with:'Jorge'.
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
	self assert: (aGame allShipsPosition at: 'Fran')
		equals: #( 6 1 ) asOrderedCollection.
	self assert: (aGame allShipsPosition at: 'Jorge')
		equals: #( 2 1 ) asOrderedCollection
]

{ #category : #tests }
EffectsTest >> testWhenApplyingHyperSpaceJumpEffectShipLosesAShield [

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 4 put: HyperSpaceJumpEffect new;
		                        yourself.

	aBoard := SetBoard
		          withLengthInTileAndParsec: #( 10 10 )
		          withWormHolePositions: #( 2 5 )
		          withAmountOfLaps: 1
		          withEffectsInPosition: aDictionaryOfEffects.

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

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 4 put: HyperSpaceJumpEffect new;
		                        yourself.

	aBoard := SetBoard
		          withLengthInTileAndParsec: #( 10 10 )
		          withWormHolePositions: #( 2 5 )
		          withAmountOfLaps: 1
		          withEffectsInPosition: aDictionaryOfEffects.

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

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 13
		                        put:
			                        (MoonWalkEffect withMoonwalkDistance: 3);
		                        yourself.
	aBoard := SetBoard
		          withLengthInTileAndParsec: #( 20 20 )
		          withWormHolePositions: #( 2 5 )
		          withAmountOfLaps: 1
		          withEffectsInPosition: aDictionaryOfEffects.

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

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 5
		                        put:
			                        (MoonWalkEffect withMoonwalkDistance: 3);
		                        yourself.
	aBoard := SetBoard
		          withLengthInTileAndParsec: #( 10 10 )
		          withWormHolePositions: #( 4 6 )
		          withAmountOfLaps: 3
		          withEffectsInPosition: aDictionaryOfEffects.
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

	| aGame aBoard aWormHolePair aShipName |
	aWormHolePair := #( 2 5 ).
	aBoard := SetBoard
		          withLengthInTileAndParsec: #( 6 6 )
		          withWormHolePositions: aWormHolePair
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
