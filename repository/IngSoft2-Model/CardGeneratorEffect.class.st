"
a
"
Class {
	#name : #CardGeneratorEffect,
	#superclass : #Effect,
	#instVars : [
		'probabilityCards',
		'probabilityManager'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardGeneratorEffect class >> withProbabilities: aCollectionOfProbabilities [

	^ self new initalizeWithProbabilities: aCollectionOfProbabilities
]

{ #category : #applying }
CardGeneratorEffect >> affectAShip: aShip [

	^ self
]

{ #category : #applying }
CardGeneratorEffect >> applyOn: aGame [

	self affectAShip: self.
	aGame giveCardToCurrentShip: self generateRandomCard
]

{ #category : #generators }
CardGeneratorEffect >> generateParameters: aTileEffectCreator [

	aTileEffectCreator generateCardGeneratorParameters: self
]

{ #category : #applying }
CardGeneratorEffect >> generateRandomCard [

	^ probabilityManager elementAtRandom: probabilityCards
]

{ #category : #initialization }
CardGeneratorEffect >> initalizeWithProbabilities: aCollectionOfCardProbabilities [ 
	
	
	probabilityManager := ProbabilityManager new.
	
	 probabilityCards := probabilityManager transformIntoProbabilityRanges: aCollectionOfCardProbabilities .  
]
