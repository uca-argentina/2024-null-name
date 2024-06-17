"
lightyear class
"
Class {
	#name : #LightYear,
	#superclass : #Unit,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
LightYear class >> ratioInParsecs [

	^ 1
]

{ #category : #initialization }
LightYear >> initializeWithNominalValue: aNominalValue [

	nominalValue := aNominalValue.
]
