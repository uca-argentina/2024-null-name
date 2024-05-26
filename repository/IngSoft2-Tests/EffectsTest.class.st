Class {
	#name : #EffectsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectsTest >> testWhenApplyingAtomicBombEffectAllShipsMoveBackToFirstTile [

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 7
		                        put:
			                        (OrderedCollection with: AtomicBombEffect);
		                        yourself.

	aBoard := SetBoard
		          withTiles: 10
		          withWormHolePositions: #( 2 5 )
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
					           (SequenceDie withSequence: #( 3 2 4 )))).
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self
		assert: (aGame allShipPositions at: 'Juan')
		equals: #( 1 1 ) asOrderedCollection.
	self
		assert: (aGame allShipPositions at: 'Pedro')
		equals: #( 1 1 ) asOrderedCollection.
	self
		assert: (aGame allShipPositions at: 'Jose')
		equals: #( 1 1 ) asOrderedCollection
]

{ #category : #tests }
EffectsTest >> testWhenApplyingBlackHoleEffectShipMoves4SpacesBack [

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 8
		                        put:
			                        (OrderedCollection
				                         with: BlackHoleEffect);
		                        yourself.

	aBoard := SetBoard
		          withTiles: 10
		          withWormHolePositions: #( 2 5 )
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
		assert: (aGame allShipPositions at: 'Juan')
		equals: #( 4 1 ) asOrderedCollection.
]

{ #category : #tests }
EffectsTest >> testWhenApplyingBlackHoleShipNotOnLap1CanMoveBelowFirstTilePosition [

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 3
		                        put:
			                        (OrderedCollection with: BlackHoleEffect);
		                        yourself.
	aBoard := SetBoard
		          withTiles: 10
		          withWormHolePositions: #( 2 5 )
		          withEffectsInPosition: aDictionaryOfEffects
		          withAmountOfLaps: 3.

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
		assert: (aGame allShipPositions at: 'Juan')
		equals: #( 9 1 ) asOrderedCollection
]

{ #category : #tests }
EffectsTest >> testWhenApplyingHyperJumpEffectShipMovesAVariableParsecDistance [

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 3 put: (OrderedCollection
				                         with: HyperJumpEffect
				                         with:
					                         (OrderedCollection
						                          with: #( 2 5 3 1 )
						                          with: #( 10 20 )));
		                        yourself.

	aBoard := SetBoard
		          withTiles: 20
		          withWormHolePositions: #( 2 5 )
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
		assert: (aGame allShipPositions at: 'Juan')
		equals: #( 13 1 ) asOrderedCollection.
]

{ #category : #tests }
EffectsTest >> testWhenApplyingHyperSpaceJumpEffectShipLosesAShield [

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 4
		                        put:
			                        (OrderedCollection
				                         with: HyperSpaceJumpEffect);
		                        yourself.

	aBoard := SetBoard
		          withTiles: 20
		          withWormHolePositions: #( 2 5 )
		          withEffectsInPosition: aDictionaryOfEffects.
	aShipName := OrderedCollection with: 'Juan'.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aShipName
		         withDice: (Dice with:
				          (OrderedCollection with:
					           (SequenceDie withSequence: #( 3 )))).

	aGame playTurn.

	self assert: (aGame allShipAmountOfShields at: 'Juan') equals: 2.
]

{ #category : #tests }
EffectsTest >> testWhenApplyingHyperSpaceJumpEffectShipMoves4SpacesForward [

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 4
		                        put:
			                        (OrderedCollection
				                         with: HyperSpaceJumpEffect);
		                        yourself.

	aBoard := SetBoard
		          withTiles: 20
		          withWormHolePositions: #( 2 5 )
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
		assert: (aGame allShipPositions at: 'Juan')
		equals: #( 8 1 ) asOrderedCollection.
]

{ #category : #tests }
EffectsTest >> testWhenApplyingMoonWalkEffectAllShipsButTriggeringShipMoveAVariableDistance [

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 13
		                        put:
			                        (OrderedCollection
				                         with: MoonWalkEffect
				                         with: 3);
		                        yourself.
	aBoard := SetBoard
		          withTiles: 20
		          withWormHolePositions: #( 2 5 )
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
		assert: (aGame allShipPositions at: 'Juan')
		equals: #( 13 1 ) asOrderedCollection.
	self
		assert: (aGame allShipPositions at: 'Pedro')
		equals: #( 5 1 ) asOrderedCollection
]

{ #category : #tests }
EffectsTest >> testWhenApplyingMoonWalkEffectShipLapsBehaveCorrectly [

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 5
		                        put:
			                        (OrderedCollection
				                         with: MoonWalkEffect
				                         with: 3);
		                        yourself.
	aBoard := SetBoard
		          withTiles: 10
		          withWormHolePositions: #( 4 6 )
		          withEffectsInPosition: aDictionaryOfEffects
		          withAmountOfLaps: 3.
	aShipName := OrderedCollection with: 'Juan' with: 'Pedro' with: 'Jose'.
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
		assert: (aGame allShipPositions at: 'Juan')
		equals: #( 10 1 ) asOrderedCollection.
	self
		assert: (aGame allShipPositions at: 'Pedro')
		equals: #( 5 2 ) asOrderedCollection.
	self
		assert: (aGame allShipPositions at: 'Jose')
		equals: #( 1 1 ) asOrderedCollection
]

{ #category : #tests }
EffectsTest >> testWhenApplyingWormholeEffectOnShipMoveAccordingly [

	| aGame aBoard aWormholePositons aShipName |
	aWormholePositons := #( 2 5 ).
	aBoard := SetBoard
		          withTiles: 6
		          withWormHolePositions: aWormholePositons.
	aShipName := OrderedCollection with: 'Juan'.
	aGame := Game
		         withBoard: aBoard
		         withShipNames: aShipName
		         withDice: (Dice with:
				          (OrderedCollection with:
					           (SequenceDie withSequence: #( 1 )))).

	aGame playTurn.
	
	self
		assert: (aGame allShipPositions at: 'Juan')
		equals: #( 5 1 ) asOrderedCollection
]
