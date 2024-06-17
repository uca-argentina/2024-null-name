Class {
	#name : #PermanentCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
PermanentCard >> canPlayRightNow: theShipInTurn [

	^ theShipInTurn shipName = holder
]
