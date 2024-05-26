"
Game Class
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'gameBoard',
		'gameShips',
		'dice',
		'gameTurnHandler',
		'shipBattleHandler',
		'theShipInCurrentTurn'
	],
	#classInstVars : [
		'isFinished'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
Game class >> isValid: aBoard with: aNameCollection and: aDice [

	aNameCollection isEmpty ifTrue: [
		Error signal: 'Game cannot be created without any Ship names' ].
	aBoard ifNil: [
		Error signal: 'Game cannot be started without a board' ].
	aDice ifNil: [
		Error signal: 'Game cannot be started without at least one die' ]
]

{ #category : #'class initialization' }
Game class >> withBoard: aBoard withShipNames: aNameCollection withDice: aDice [

	self isValid: aBoard with: aNameCollection and: aDice.
	^ self new
		  initializeGameWith: aBoard
		  withShipNames: aNameCollection asSet
		  withDice: aDice
		  withAmountOfLaps: 1
]

{ #category : #accessing }
Game >> allShipAmountOfShields [

	| shipShields |
	shipShields := Dictionary new.
	gameShips do: [ :aShip |
		shipShields
			at: aShip shipName put: aShip amountOfShieldsActive;
			yourself ].
	^ shipShields
]

{ #category : #accessing }
Game >> allShipPositions [

	| shipPositions |
	shipPositions := Dictionary new.
	gameShips do: [ :aShip |
		shipPositions
			at: aShip shipName
			put: (OrderedCollection with: aShip position with: aShip lapsLeft);
			yourself ].
	^ shipPositions
]

{ #category : #event }
Game >> applyEffectOnAllShips: anEffect [

	anEffect affectAShipCollection: gameShips.
	gameShips do: [ :aShip |
		gameBoard adjustShipPositionOverboard: aShip.
		gameBoard adjustShipPositionBelowOne: aShip ]
]

{ #category : #event }
Game >> applyEffectOnAllShipsButOne: anEffect [

	anEffect affectAllShips: gameShips but: theShipInCurrentTurn.
	gameShips do: [ :aShip |
		gameBoard adjustShipPositionOverboard: aShip.
		gameBoard adjustShipPositionBelowOne: aShip ]
]

{ #category : #event }
Game >> applyEffectOnOneShip: anEffect [

	anEffect affectAShip: theShipInCurrentTurn.
	gameShips do: [ :aShip |
		gameBoard adjustShipPositionOverboard: aShip.
		gameBoard adjustShipPositionBelowOne: aShip ]
]

{ #category : #initialization }
Game >> initializeGameWith: aBoard withShipNames: aNameCollection withDice: aDice withAmountOfLaps: anAmountOfLaps [

	gameBoard := aBoard.
	gameShips := aNameCollection asOrderedCollection collect: [ :aName |
		             Ship createWithName: aName ].
	dice := aDice.
	gameTurnHandler := TurnHandler withAnAmountOfTurns: gameShips size.
	shipBattleHandler := ShipBattle withDice: dice withShips: gameShips
]

{ #category : #testing }
Game >> isFinished [

	^ gameShips anySatisfy: [ :aShip | gameBoard isInLastTile: aShip ]
]

{ #category : #modifying }
Game >> loseTurn: aShip [

	gameTurnHandler nextTurn.
	aShip lostTurnCounterDown.
	^ aShip shipName , ' lost their turn'
]

{ #category : #modifying }
Game >> playTurn [

	| movement |
	gameTurnHandler canPlayNextTurnOf: self isFinished.
	theShipInCurrentTurn := gameShips at: gameTurnHandler currentTurn.

	theShipInCurrentTurn canPlayTurn ifFalse: [
		^ self loseTurn: theShipInCurrentTurn ].

	movement := dice throw.
	theShipInCurrentTurn moveTiles: movement.
	gameBoard adjustShipPositionOverboard: theShipInCurrentTurn.
	gameBoard snapToLastTile: theShipInCurrentTurn.
	gameBoard applyTileEffectOn: self triggeredBy: theShipInCurrentTurn.
	shipBattleHandler checkShipBattle: theShipInCurrentTurn.
	gameTurnHandler nextTurn
]

{ #category : #modifying }
Game >> skipTurn [

	gameTurnHandler canPlayNextTurnOf: self isFinished.
	theShipInCurrentTurn := gameShips at: gameTurnHandler currentTurn.
	
	theShipInCurrentTurn canPlayTurn ifFalse: [
		^ self loseTurn: theShipInCurrentTurn ].
	
	theShipInCurrentTurn healFullShields.
	gameTurnHandler nextTurn.
	^ theShipInCurrentTurn shipName , ' skipped their turn'
]

{ #category : #accessing }
Game >> winnerName [

	self isFinished ifFalse: [ ^ 'There is no winner yet' ].
	^ (gameShips detect: [ :aShip | gameBoard isInLastTile: aShip ])
		  shipName
]
