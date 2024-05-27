Class {
	#name : #GameInitalizationTest,
	#superclass : #GameTest,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameInitalizationTest >> testGameCannotBeInitializedWithoutABoard [

	| aBoard aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection with: 'Juan'.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 9).
	
	self
		should: [
			Game
				withBoard: aBoard
				withShipNames: aCollectionOfNames
				withDice: (Dice with: aCollectionOfDie) ]
		raise: Error
		withMessage: 'Game cannot be started without a board'
]

{ #category : #tests }
GameInitalizationTest >> testGameCannotBeInitializedWithoutADice [

	| aBoard aCollectionOfNames aDie |
	aCollectionOfNames := OrderedCollection with: 'Juan'.
	aBoard := SetBoard withTiles: 13 withAmountOfLaps: 1.



	self
		should: [
			Game
				withBoard: aBoard
				withShipNames: aCollectionOfNames
				withDice: aDie ]
		raise: Error
		withMessage: 'Game cannot be started without at least one die'
]

{ #category : #tests }
GameInitalizationTest >> testGameCannotBeInitializedWithoutAnyShipNames [

	| aCollectionOfNames aCollectionOfDie |
	aCollectionOfNames := OrderedCollection new.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 9).
	self
		should: [
			Game
				withBoard: (SetBoard withTiles: 20 withAmountOfLaps:1)
				withShipNames: aCollectionOfNames
				withDice: (Dice with: aCollectionOfDie) ]
		raise: Error
		withMessage: 'Game cannot be created without any Ship names'
]

{ #category : #tests }
GameInitalizationTest >> testGameDoesNotAllowRepeatedShipNames [

	| aGame aBoard aCollectionOfNames aCollectionOfDie |
	aBoard := SetBoard withTiles: 5 withAmountOfLaps: 1.
	aCollectionOfNames := OrderedCollection
		                      with: 'Juan'
		                      with: 'Jose'
		                      with: 'Fran'
		                      with: 'Juan'.
	aCollectionOfDie := OrderedCollection with: (LoadedDie of: 9).

	aGame := Game
		         withBoard: aBoard
		         withShipNames: aCollectionOfNames
		         withDice: (Dice with: aCollectionOfDie).
	self assert: aGame allShipsPosition size equals: 3
]
