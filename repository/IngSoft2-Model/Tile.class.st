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

{ #category : #'as yet unclassified' }
Tile class >> inPosition: aPosition [ 
	(aPosition < 0) ifTrue: [Error signal: 'Tile cannot have a negative position'].
	^ (self new) inPosition: aPosition.
]

{ #category : #'class initialization' }
Tile class >> inPosition: aPosition withWormholeTo: aTilePosition [ 
	(aPosition < 0) ifTrue: [Error signal: 'Tile cannot have a negative position'].
	^ (self new) inPosition: aPosition withWormholeTo: aTilePosition .
]

{ #category : #modifying }
Tile >> applyEffectOn: aShip [ 
	effect applyOn: aShip.
]

{ #category : #accessing }
Tile >> givePosition [
	^position.
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
