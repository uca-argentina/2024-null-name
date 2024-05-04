Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameTest >> should: anErrorBlock raise: exceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: exceptionClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : #tests }
GameTest >> testIfGameIsFinishedRerurnTrue [

|aGame|.

aGame:= Game startGame.
aGame endGame.

self deny: (aGame isOngoing )
]

{ #category : #tests }
GameTest >> testIfGameIsNotFinishedRerurnFalse [

|aGame|

aGame:= Game startGame.

self assert: (aGame isOngoing)
]

{ #category : #tests }
GameTest >> testIfGameNotStartedThrowError [

| aGame |
aGame:= Game new.

self assert:(true)
]
