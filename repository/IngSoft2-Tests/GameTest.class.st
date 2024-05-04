Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testIfGameIsFinishedRerurnTrue [

|aGame|.

aGame:= Game new.
aGame endGame.

self deny: (aGame isOngoing )
]

{ #category : #tests }
GameTest >> testIfGameNotStartedThrowError [

| aGame |
aGame:= Game new.

self assert:(false)
]
