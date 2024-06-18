Class {
	#name : #MercenaryCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
MercenaryCard >> activate: aCardHandler withTarget: aTarget withBlockOfCode: aBlockOfCode [
	aBlockOfCode value: holder value: aTarget 
]

{ #category : #comparing }
MercenaryCard >> canPlayRightNow: theShipInTurn [

	^ theShipInTurn shipName = holder
]
