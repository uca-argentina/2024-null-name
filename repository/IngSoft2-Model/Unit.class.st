"
pharo deja de chillar
"
Class {
	#name : #Unit,
	#superclass : #Object,
	#instVars : [
		'nominalValue'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Unit class >> ratioInParsecs [
	^ self subclassResponsibility
]

{ #category : #testing }
Unit class >> withNominalValue: aNominalValue [

	^ self new initializeWithNominalValue: aNominalValue
]

{ #category : #modifying }
Unit >> > aUnit [

	^ nominalValue > (aUnit toUnit: self class) nominalValue
]

{ #category : #initialization }
Unit >> initializeWithNominalValue: aNominalValue [

	self subclassResponsibility
]

{ #category : #accessing }
Unit >> nominalValue [

	^ nominalValue
]

{ #category : #modifying }
Unit >> toUnit: aUnit [

	^ aUnit withNominalValue:
		  nominalValue * (aUnit ratioInParsecs / self class ratioInParsecs)
]
