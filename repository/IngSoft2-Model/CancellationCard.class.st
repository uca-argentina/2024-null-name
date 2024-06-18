"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) desi
"
Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#instVars : [
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
CancellationCard >> activate: aCardHandler withTarget: aTarget [

	aCardHandler removeFromActiveCard: aTarget.
]

{ #category : #comparing }
CancellationCard >> canPlayRightNow: theShipInTurn [

	^ true
]

{ #category : #comparing }
CancellationCard >> hasTarget: aTarget [

	^ target = aTarget
]

{ #category : #comparing }
CancellationCard >> withTarget: aTarget [

	target := aTarget
]