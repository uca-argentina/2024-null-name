Class {
	#name : #ShipCoalition,
	#superclass : #Object,
	#instVars : [
		'leader',
		'mercenary'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
ShipCoalition class >> withLeader: aLeader andMercenary: aMercenary [

	^ self new initializeWithLeader: aLeader andMercenary: aMercenary
]

{ #category : #comparing }
ShipCoalition >> = anotherCoalition [

	^ self hash = anotherCoalition hash
]

{ #category : #testing }
ShipCoalition >> hasLeader: aShipName [

	^ leader = aShipName
]

{ #category : #comparing }
ShipCoalition >> hash [

	^ leader hash + mercenary hash
]

{ #category : #initialization }
ShipCoalition >> initializeWithLeader: aLeader andMercenary: aMercenary [

	leader := aLeader.
	mercenary := aMercenary.
]

{ #category : #accessing }
ShipCoalition >> mercenary [

	^ mercenary
]
