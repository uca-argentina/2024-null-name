"
black hole tile class, polymorphic with tile class
"
Class {
	#name : #BlackHoleTile,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
BlackHoleTile class >> inPosition: aPosition [ 
	(aPosition < 0) ifTrue: [Error signal: 'Black hole tile cannot have a negative position'].
	^ (self new) inPosition: aPosition.
]

{ #category : #initialization }
BlackHoleTile >> givePosition [
	^position.
]

{ #category : #initialization }
BlackHoleTile >> inPosition: aPosition [ 
	position := aPosition.
]
