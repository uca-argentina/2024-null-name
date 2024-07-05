"
a
"
Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'holder'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Card class >> withHolder: aShipName [

	^ self new initalizeWithHolder: aShipName
]

{ #category : #comparing }
Card >> = aCard [

	^ self hash = aCard hash and: self class = aCard class
]

{ #category : #modifying }
Card >> activate: aCardHandler withTarget: aShipName [

	^ self subclassResponsibility
]

{ #category : #comparing }
Card >> applyMovement [

	^ 0
]

{ #category : #comparing }
Card >> canPlayRightNow: theShipInTurn [

	self subclassResponsibility
]

{ #category : #comparing }
Card >> hash [

	^ holder hash
]

{ #category : #accessing }
Card >> holder [

	^ holder
]

{ #category : #initialization }
Card >> initalizeWithHolder: aShipName [

	holder := aShipName
]

{ #category : #comparing }
Card >> shouldApplyOn: aTarget [

	^ true
]
