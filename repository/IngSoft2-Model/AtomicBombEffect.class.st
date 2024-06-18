"
atomic bomb effect
"
Class {
	#name : #AtomicBombEffect,
	#superclass : #EffectOnAllShips,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
AtomicBombEffect >> affectAShipCollection: aShipCollection [

	aShipCollection do: [ :aShip |
		aShip loseOneShield.
		aShip moveToFirstTile ]
]
