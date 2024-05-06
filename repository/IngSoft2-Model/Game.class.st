"
Game Class
"
Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'isFinished',
		'gameBoard',
		'gameShips'
	],
	#classInstVars : [
		'isFinished'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Game class >> withBoard: aBoard withPlayers: aNameCollection [
	aBoard ifNil: [
		Error signal: 'Game cannot be started without a board' ].
	aNameCollection ifNil: [ 
		Error signal: 'Game cannot be started without at least one ship.' ].
	^ self new beginGameWith: aBoard withPlayers: (aNameCollection asSet)
]

{ #category : #accessing }
Game >> amountOfShips [
	^ gameShips size .
]

{ #category : #initialization }
Game >> beginGameWith: aBoard withPlayers: aNameCollection [
	| aCollectionShips |
	gameBoard := aBoard.
	aCollectionShips := OrderedCollection new.
	1 to: (aNameCollection size) do: [ :iter | aCollectionShips add: (Ship createWithName: ((aNameCollection asOrderedCollection) at: iter))].
	
	gameShips:=aCollectionShips.
	
	isFinished := false.
]

{ #category : #accessing }
Game >> board [
	^gameBoard
]

{ #category : #accessing }
Game >> endGame [
	isFinished := true
]

{ #category : #testing }
Game >> isOngoing [
	^ isFinished not.
]
