"
a Dice collection made out of multiple Die
"
Class {
	#name : #Dice,
	#superclass : #OrderedCollection,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
Dice >> throw [ 
	^(self collect: [ :die|die throw ]) sum.
]
