"
Wormhole effect
moves ship to another fixed position
"
Class {
	#name : #WormholeEffect,
	#superclass : #EffectOnOneShip,
	#instVars : [
		'wormholeDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
WormholeEffect class >> createWith: aDistance [
	^ (self new) initializeWithDistance: aDistance

]

{ #category : #'instance creation' }
WormholeEffect class >> fromPosition: firstPosition toPosition: endPosition [

	^ self new
		  initializeInPosition: firstPosition
		  toPosition: endPosition
]

{ #category : #applying }
WormholeEffect >> affectAShip: aShip [

	aShip moveTiles: wormholeDistance
]

{ #category : #'instance creation' }
WormholeEffect >> initializeInPosition: firstPosition toPosition: endPosition [

	wormholeDistance := endPosition - firstPosition
]

{ #category : #'instance creation' }
WormholeEffect >> initializeWithDistance: aDistance [
	wormholeDistance := aDistance
]
