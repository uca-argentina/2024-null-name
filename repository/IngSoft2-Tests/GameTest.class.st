Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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
