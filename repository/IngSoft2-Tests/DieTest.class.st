Class {
	#name : #DieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
DieTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should: aErrorBlock raise: anErrorClass withExceptionDo: [:error|self assert: error messageText equals:anErrorMessage].


]

{ #category : #asserting }
DieTest >> testDieCanBeCreatedWithAnAmountOfFaces [ 

| aDie |
	aDie:= Die of:3.
	self assert: ((aDie throw) between: 1 and:3).



]

{ #category : #asserting }
DieTest >> testDieCannotBeCreatedWithLessThanThreeFaces [ 

self should:[Die of:2] raise: Error withMessage: 'Faces should be more than 2'



]

{ #category : #asserting }
DieTest >> testWhenDieIsThrownThenValueIsBetweenOneAndNumberedFaces [ 

| aDie |
aDie:=Die of:4.

self assert:((aDie throw) between: 1 and:4).

]
