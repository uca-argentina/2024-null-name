Class {
	#name : #TileTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
TileTest >> should: anErrorBlock raise: exceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: exceptionClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
TileTest >> testPositionCannotBeLessThan0 [

	self
		should: [ Tile inPosition: -1 ]
		raise: Error
		withMessage: 'Tile cannot have a negative position'
]

{ #category : #tests }
TileTest >> testWhenAskedReturnPosition [
	| aTile |
	aTile:= Tile inPosition: 0.
	self assert: (aTile givePosition) equals: 0.
]
