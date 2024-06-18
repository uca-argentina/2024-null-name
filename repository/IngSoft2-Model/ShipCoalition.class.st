"
a
"
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

{ #category : #testing }
ShipCoalition >> hasShip: aShip [

	^ leader = aShip or: mercenary = aShip
]

{ #category : #initialization }
ShipCoalition >> initializeWithLeader: aLeader andMercenary: aMercenary [

	leader := aLeader.
	mercenary := aMercenary
]

{ #category : #comparison }
ShipCoalition >> leaderIs: aShip [

	^ aShip = leader
]

{ #category : #accessing }
ShipCoalition >> mercenary [

	^ mercenary
]
