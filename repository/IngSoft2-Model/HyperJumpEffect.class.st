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
HyperJumpEffect class >> createWith: aCollectionOfParameters [
	^ (self new) initializeWithParsecs: aCollectionOfParameters.
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

{ #category : #initialization }
HyperJumpEffect >> initializeWithParsecs: aCollectionOfParameters [

	parsecCollection := (aCollectionOfParameters at: 'parsecArray')
		                    asSortedCollection: [ :a :b | a > b ].

	boardParsecToTileRatio := (aCollectionOfParameters
		                          at: 'Tiles') // (aCollectionOfParameters
		                          at: 'Parsecs').
	parsecNumber := 0
]
