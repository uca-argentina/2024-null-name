"
moon walk effect class
"
Class {
	#name : #MoonWalkEffect,
	#superclass : #EffectOnAllShipsButOne,
	#instVars : [
		'moonWalkDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
MoonWalkEffect class >> createWith: aDistance [

	^ self new initializeWithDistance: aDistance 
]

{ #category : #applying }
MoonWalkEffect >> affectAllShips: aShipCollection but: currentTurnShip [

	aShipCollection
		reject: [ :aShip | aShip = currentTurnShip ]
		thenCollect: [ :aShip | aShip moveTiles: moonWalkDistance negated ]
]

{ #category : #initialization }
MoonWalkEffect >> initializeWithDistance: aDistance [

	moonWalkDistance := aDistance
]
