"
aS
"
Class {
	#name : #HyperJumpEffect,
	#superclass : #Effect,
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

{ #category : #'as yet unclassified' }
HyperJumpEffect >> currentParsec [

	parsecNumber := parsecNumber < parsecCollection size
		                ifTrue: [ parsecNumber + 1 ]
		                ifFalse: [ 1 ].
	^ parsecNumber
]

{ #category : #initialization }
HyperJumpEffect >> initializeWithParsecs: aCollectionOfParameters [

	parsecCollection := aCollectionOfParameters first
		                    asSortedCollection: [ :a :b | a > b ].

	boardParsecToTileRatio := aCollectionOfParameters last last
	                          // aCollectionOfParameters last first.

	parsecNumber := 0
]
