"
a
"
Class {
	#name : #ProbabilityManager,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #generating }
ProbabilityManager >> elementAtRandom: probabilityElements [

	| aRandomNumber aCardClass |
	aRandomNumber := (1 to: 100) atRandom asInteger.

	aCardClass := (probabilityElements detect: [ :aProbabilityCard |
		               aProbabilityCard rangeIncludes: aRandomNumber ])
		              associatedObject.

	^ aCardClass
]

{ #category : #modifying }
ProbabilityManager >> transformIntoProbabilityRanges: aProbabilityDistributionCollection [

	| acc |
	acc := 0.

	aProbabilityDistributionCollection do: [ :effectProbability |
		effectProbability setRange: acc.
		acc := acc + effectProbability probability].
	^ aProbabilityDistributionCollection
]
