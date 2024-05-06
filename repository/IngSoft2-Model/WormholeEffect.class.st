"
Wormhole effect
moves ship to another fixed position
"
Class {
	#name : #WormholeEffect,
	#superclass : #Effect,
	#instVars : [
		'wormholeDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
WormholeEffect class >> fromTile: firstTilePosition toTile: endTilePosition [ 
	^ (self new) fromTile: firstTilePosition toTile: endTilePosition.
]

{ #category : #applying }
WormholeEffect >> applyOn: aShip [ 
	aShip moveTiles: wormholeDistance.
]

{ #category : #'instance creation' }
WormholeEffect >> fromTile: firstTilePosition toTile: endTilePosition [ 
	wormholeDistance:= endTilePosition - firstTilePosition .
]
