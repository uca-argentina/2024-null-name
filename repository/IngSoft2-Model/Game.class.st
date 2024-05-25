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

{ #category : #'class initialization' }
Game class >> withBoard: aBoard withShipNames: aNameCollection withDice: aDice withAmountOfLaps: anAmountOfLaps [

	self isValid: aBoard with: aNameCollection and: aDice.
	^ self new
		  initializeGameWith: aBoard
		  withShipNames: aNameCollection asSet
		  withDice: aDice
		  withAmountOfLaps: anAmountOfLaps
]

{ #category : #accessing }
Game >> allShipAmountOfShields [

	^ gameShips collect: [ :aShip | aShip amountOfShieldsActive ]
]

{ #category : #accessing }
Game >> allShipPositions [

	^ gameShips collect: [ :aShip |
		  OrderedCollection new
			  add: aShip position;
			  add: aShip lapsLeft;
			  add: aShip shipName;
			  yourself ]
]

{ #category : #'as yet unclassified' }
Game >> applyEffectOnAllShips: anEffect [ 
	anEffect affectAShipCollection: gameShips.
]

{ #category : #'as yet unclassified' }
Game >> applyEffectOnOneShip: anEffect [
	anEffect affectAShip: theShipInCurrentTurn 
]

{ #category : #initialization }
Game >> initializeGameWith: aBoard withShipNames: aNameCollection withDice: aDice withAmountOfLaps: anAmountOfLaps [

	| aCollectionShips |
	gameBoard := aBoard.
	aCollectionShips := OrderedCollection new.
	1 to: aNameCollection size do: [ :iter |
		aCollectionShips add: (Ship
				 createWithName: (aNameCollection asOrderedCollection at: iter)
				 withAmountOfLaps: anAmountOfLaps) ].
	gameShips := aCollectionShips.
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
	gameBoard adjustPositionAfterLap: theShipInCurrentTurn.
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
