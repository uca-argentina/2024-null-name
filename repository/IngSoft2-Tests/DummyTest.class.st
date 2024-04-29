Class {
	#name : #DummyTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DummyTest >> testDumm [

	self assert: Dummy new isDummy
]

{ #category : #tests }
DummyTest >> testDummy [

	self assert: Dummy new isDummy
]
