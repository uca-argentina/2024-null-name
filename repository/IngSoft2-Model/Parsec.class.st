"
parsec class
"
Class {
	#name : #Parsec,
	#superclass : #Unit,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Parsec class >> ratioInParsecs [

	^ 1
]

{ #category : #initialization }
Parsec >> initializeWithNominalValue: aNominalValue [

	nominalValue := aNominalValue.
]
