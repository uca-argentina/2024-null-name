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

	^ holder = aCard holder
]

{ #category : #comparing }
Card >> hash [

	^ holder hash.
]

{ #category : #accessing }
Card >> holder [

	^ holder
]

{ #category : #initialization }
Card >> initalizeWithHolder: aShipName [

	holder := aShipName
]
