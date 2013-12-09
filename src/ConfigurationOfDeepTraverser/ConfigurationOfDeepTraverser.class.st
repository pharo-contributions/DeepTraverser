"
self loadDevelopment
"
Class {
	#name : #ConfigurationOfDeepTraverser,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #ConfigurationOfDeepTraverser
}

{ #category : #private }
ConfigurationOfDeepTraverser class >> ensureMetacello [
	Smalltalk at: #MetacelloProject ifAbsent: [
		Gofer new
				url: 'http://seaside.gemstone.com/ss/metacello';
				addPackage: 'ConfigurationOfMetacello';
				load.
		(Smalltalk at: #ConfigurationOfMetacello) loadLatestVersion ]
]

{ #category : #'metacello tool support' }
ConfigurationOfDeepTraverser class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfDeepTraverser class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #loading }
ConfigurationOfDeepTraverser class >> loadStable [
	(self project version: #'stable') load
]

{ #category : #accessing }
ConfigurationOfDeepTraverser class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfDeepTraverser >> baseline10: spec [ 
	<version: '1.0-baseline'>
	
	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'First version'.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/DeepTraverser/main'.
		spec package: 'DeepTraverser'.
		spec group: 'Tests' with: #('DeepTraverser'). 
	]
]

{ #category : #'symbolic versions' }
ConfigurationOfDeepTraverser >> development: spec [ 
	<symbolicVersion: 'development'>
	
	spec for: #common version: '1.0-baseline'
]

{ #category : #accessing }
ConfigurationOfDeepTraverser >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project]
]