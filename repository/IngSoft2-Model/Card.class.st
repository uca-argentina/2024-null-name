"
a
"
Class {
	#name : #Card,
	#superclass : #Object,
	#instVars : [
		'holder',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
Card class >> withHolder: aShipName [

	^ self new initalizeWithHolder: aShipName withTarget: NullTarget new
]

{ #category : #'class initialization' }
Card class >> withHolder: aShipName andTarget: aTarget [

	^ self new initalizeWithHolder: aShipName withTarget: aTarget
]

{ #category : #comparing }
Card >> = aCard [

	^ self hash = aCard hash and: self class = aCard class
]

{ #category : #event }
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

{ #category : #event }
Card >> deactivate: aCardHandler [

	^ self
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
Card >> initalizeWithHolder: aShipName withTarget: aTarget [

	holder := aShipName.
	target := aTarget.
]

{ #category : #comparing }
Card >> shouldApplyOn: aTarget [

	^ true
]
