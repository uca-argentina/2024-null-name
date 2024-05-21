Class {
	#name : #DieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DieTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: aErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
DieTest >> testDiceHasNDieInIT [

	| aDice |
	aDice := Dice with: (OrderedCollection
			          with: (Die of: 3)
			          with: (Die of: 4)
			          with: (Die of: 5)).
	self assert: aDice numberOfDie equals: 3
]

{ #category : #tests }
DieTest >> testDiceRequiresAtLeastOneDie [

	self
		should: [ Dice with: OrderedCollection new ]
		raise: Error
		withMessage: 'There should be at least 1 Die'
]

{ #category : #tests }
DieTest >> testDiceRollBetweenThesizeOfDiceAndTheSumOfTheDieFaces [

	| aDice |
	
	aDice := Dice with: (OrderedCollection with:(Die of: 3) with: (Die of: 4) with: (Die of: 5) ).
	self assert: (aDice throw between: 3 and: 12)
]

{ #category : #asserting }
DieTest >> testDieCanBeCreatedWithAnAmountOfFaces [

	| aDie |
	aDie := Die of: 3.
	self assert: (aDie throw between: 1 and: 3)
]

{ #category : #asserting }
DieTest >> testDieCannotBeCreatedWithLessThanThreeFaces [

	self
		should: [ Die of: 2 ]
		raise: Error
		withMessage: 'Faces should be more than 2'
]

{ #category : #asserting }
DieTest >> testWhenDieIsThrownThenValueIsBetweenOneAndNumberedFaces [

	| aDie |
	aDie := Die of: 4.

	self assert: (aDie throw between: 1 and: 4)
]
