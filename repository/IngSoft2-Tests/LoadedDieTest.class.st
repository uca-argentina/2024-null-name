Class {
	#name : #LoadedDieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
LoadedDieTest >> should: aErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should: aErrorBlock raise: anErrorClass withExceptionDo: [:error|self assert: error messageText equals:anErrorMessage]
]

{ #category : #asserting }
LoadedDieTest >> testDieCanBeCreatedWithAnAmountOfFaces [ 

| aDie |
aDie:= LoadedDie of:5.
self assert: aDie throw equals:5.
]

{ #category : #asserting }
LoadedDieTest >> testDieCannotBeCreatedWithLessThanThreeFaces [ 

self should:[LoadedDie of:2] raise: Error withMessage: 'Faces should be more than 2'
]

{ #category : #tests }
LoadedDieTest >> testWhenDieIsThrownThenValueIsBetweenOneAndNumberedFaces [ 

| aDie |
aDie:=LoadedDie  of:4.

self assert:(aDie throw) equals:4.
]
