"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestIngSoft2Tests,
	#superclass : #PackageManifest,
	#category : #'IngSoft2-Tests-Manifest'
}

{ #category : #'code-critics' }
ManifestIngSoft2Tests class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#GameTest #testGameCannotBeInitializedWithoutABoard #false)) #'2024-05-04T19:09:38.75-03:00') #(#(#RGMethodDefinition #(#GameTest #testGameCannotBeInitializedWithoutAtLeastOneShip #false)) #'2024-05-04T19:09:49.813-03:00') )
]
