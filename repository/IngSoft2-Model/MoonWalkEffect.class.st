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

{ #category : #testing }
MoonWalkEffect class >> isValid: aDistance [

	aDistance strictlyPositive ifFalse: [
		Error signal: 'Moonwalk distance must be strictly positive' ]
]

{ #category : #'class initialization' }
MoonWalkEffect class >> withMoonwalkDistance: aDistance [
	
	self isValid:aDistance.
	
	^ self new initializeWithMoonwalkDistance: aDistance 
]

{ #category : #applying }
MoonWalkEffect >> affectAllShips: aShipCollection but: currentTurnShip [

	aShipCollection
		reject: [ :aShip | aShip = currentTurnShip ]
		thenCollect: [ :aShip | aShip moveTiles: moonWalkDistance negated ]
]

{ #category : #initialization }
MoonWalkEffect >> initializeWithMoonwalkDistance: aDistance [

	moonWalkDistance := aDistance
]
