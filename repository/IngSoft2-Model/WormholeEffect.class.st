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
WormholeEffect class >> fromPosition: firstPosition toPosition: endPosition [

	^ (self new) initializeInPosition: firstPosition toPosition: endPosition 
]

{ #category : #applying }
WormholeEffect >> applyOn: aShip [ 
    aShip moveTiles: wormholeDistance.
]

{ #category : #'instance creation' }
WormholeEffect >> initializeInPosition: firstPosition toPosition: endPosition [ 
    wormholeDistance:= endPosition - firstPosition .
]
