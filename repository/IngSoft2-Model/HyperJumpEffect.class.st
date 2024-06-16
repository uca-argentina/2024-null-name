"
aS
"
Class {
	#name : #HyperJumpEffect,
	#superclass : #EffectOnOneShip,
	#instVars : [
		'parsecCollection',
		'parsecNumber',
		'boardParsecToTileRatio'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
HyperJumpEffect class >> withParsecArray: aParsecArray andBoardLengths: aPairOfLengths [

	^ self new
		  initializeWithParsecs: aParsecArray
		  andBoardLengths: aPairOfLengths
]

{ #category : #applying }
HyperJumpEffect >> affectAShip: aShip [

	aShip moveTiles:
		(parsecCollection at: self currentParsec) * boardParsecToTileRatio
]

{ #category : #modifying }
HyperJumpEffect >> currentParsec [

	parsecNumber := parsecNumber < parsecCollection size
		                ifTrue: [ parsecNumber + 1 ]
		                ifFalse: [ 1 ].
	^ parsecNumber
]

{ #category : #generators }
HyperJumpEffect >> generateParameters: aTileEffectCreator [

	aTileEffectCreator generateHyperJumpParameters: self
]

{ #category : #initialization }
HyperJumpEffect >> initializeWithParsecs: aParsecArray andBoardLengths: aPairOfLengths [

	parsecCollection := aParsecArray asSortedCollection: [ :a :b | a > b ].

	boardParsecToTileRatio := (aPairOfLengths at: 'Tiles')
	                          // (aPairOfLengths at: 'Parsecs').
	parsecNumber := 0
]
