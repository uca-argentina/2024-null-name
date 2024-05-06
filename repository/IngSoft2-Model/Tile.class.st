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
		'position',
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Tile class >> inPosition: aPosition [ 
	(aPosition < 1) ifTrue: [Error signal: 'Tile cannot have a negative position'].
	^ (self new) inPosition: aPosition.
]

{ #category : #'class initialization' }
Tile class >> inPosition: aPosition withWormholeTo: aTilePosition [ 
	(aPosition < 1) ifTrue: [Error signal: 'Tile cannot have a negative position'].
	^ (self new) inPosition: aPosition withWormholeTo: aTilePosition .
]

{ #category : #modifying }
Tile >> applyEffectOn: aShip [ 
	effect applyOn: aShip.
]

{ #category : #testing }
Tile >> hasEffect [
	^effect 
]

{ #category : #testing }
Tile >> hasPosition: anPosition [
	^ position == anPosition
]

{ #category : #initialization }
Tile >> inPosition: aPosition [ 
	position := aPosition.
	effect:= NullEffect new.
]

{ #category : #'class initialization' }
Tile >> inPosition: aPosition withWormholeTo: aTilePosition [ 
	position := aPosition.
	effect:= WormholeEffect fromTile: position toTile: aTilePosition.
]
