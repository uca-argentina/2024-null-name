Class {
	#name : #EffectsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectsTest >> testWhenApplyingBlackHoleEffectShipMoves4SpacesBack [

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 8
		                        put:
			                        (OrderedCollection
				                         with: BlackHoleEffect
				                         with: #(  ));
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


	self assert: (((aGame allShipPositions)first)first) equals: 4
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


	self assert: (((aGame allShipPositions)first)first) equals: 13
]

{ #category : #tests }
EffectsTest >> testWhenApplyingHyperSpaceJumpEffectShipLosesAShield [

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 4
		                        put:
			                        (OrderedCollection
				                         with: HyperSpaceJumpEffect
				                         with: #(  ));
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



	self assert: ((aGame allShipAmountOfShields)first) equals: 2
]

{ #category : #tests }
EffectsTest >> testWhenApplyingHyperSpaceJumpEffectShipMoves4SpacesForward [

	| aBoard aShipName aDictionaryOfEffects aGame |
	aDictionaryOfEffects := Dictionary new
		                        at: 4
		                        put:
			                        (OrderedCollection
				                         with: HyperSpaceJumpEffect
				                         with: #(  ));
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


	self assert: (((aGame allShipPositions)first)first) equals: 8
]

{ #category : #tests }
EffectsTest >> testWhenApplyingWormholeEffectOnShipMoveAccordingly [

	| aGame aBoard aWormholePositons aShipName |
	aWormholePositons := #( 2 5 ).
	aBoard := SetBoard withTiles: 6 withWormHolePositions: aWormholePositons.
	aShipName := OrderedCollection with: 'Juan'.
	aGame := Game
		         withBoard: aBoard 
		         withShipNames: aShipName
		         withDice: (Dice with: (OrderedCollection with: (SequenceDie withSequence: #(1)))).

	aGame playTurn.
	self assert: (((aGame allShipPositions)first)first) equals: 5
]
