"
a
"
Class {
	#name : #MercenaryCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
MercenaryCard >> activate: aCardHandler withTarget: aTarget withGame: aGame [
	aGame createShipCoalitionWithLeader: holder andMercenary: aTarget 
]

{ #category : #comparing }
MercenaryCard >> canPlayRightNow: theShipInTurn [

	^ theShipInTurn shipName = holder
]
