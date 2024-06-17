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

	^ holder = aCard holder and: self class = aCard class
]

{ #category : #accessing }
Card >> holder [

	^ holder
]

{ #category : #initialization }
Card >> initalizeWithHolder: aShipName [

	holder := aShipName
]