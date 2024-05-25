Class {
	#name : #AtomicBombEffect,
	#superclass : #EffectOnAllShips,
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
AtomicBombEffect class >> createWith: aCollectionOfParameters [

	^ self new
]

{ #category : #applying }
AtomicBombEffect >> affectAShipCollection: aShipCollection [

	(aShipCollection) do: [ :aShip | aShip loseBattle ]
]
