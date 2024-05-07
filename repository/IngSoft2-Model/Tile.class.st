"
Tile Class
- knows own position
- cannot have a negative position
- wormhole [unimplemented]
"
Class {
	#name : #Tile,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Tile class >> inPosition: aPosition [ 
	(aPosition < 0) ifTrue: [Error signal: 'Tile cannot have a negative position'].
	^ (self new) inPosition: aPosition.
]

{ #category : #accessing }
Tile >> givePosition [
	^position.
]

{ #category : #initialization }
Tile >> inPosition: aPosition [ 
	position := aPosition.
]
