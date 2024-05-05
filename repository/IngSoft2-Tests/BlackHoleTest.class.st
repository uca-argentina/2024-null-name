Class {
	#name : #BlackHoleTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
BlackHoleTest >> should: anErrorBlock raise: exceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: exceptionClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
BlackHoleTest >> testPositionCannotBeLessThan0 [

	self
		should: [ BlackHoleTile inPosition: -1 ]
		raise: Error
		withMessage: 'Black hole tile cannot have a negative position'
]

{ #category : #tests }
BlackHoleTest >> testWhenAskedReturnPosition [
	| aTile |
	aTile:= Tile inPosition: 0.
	self assert: (aTile givePosition) equals: 0.
]
