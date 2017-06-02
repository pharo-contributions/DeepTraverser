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

{ #category : #baselines }
ConfigurationOfDeepTraverser >> baseline11: spec [
	<version: '1.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://www.smalltalkhub.com/mc/Moose/DeepTraverser/main'.
		spec project: 'GTExamples' with: [
				spec
					className: #ConfigurationOfGTExamples;
					versionString: #'development';
					loads: #('Core' );
					repository: 'http://smalltalkhub.com/mc/Moose/GToolkit/main/' ].
		spec 
			package: 'DeepTraverser';
			package: #'DeepTraverser-Examples' with: [
				spec requires: #('DeepTraverser' 'GTExamples' ). ];
			package: #'DeepTraverser-Tests' with: [
				spec requires: #('DeepTraverser' ). ].
		spec 
			group: 'Core' with: #('DeepTraverser' );
			group: 'Examples' with: #(#'DeepTraverser-Examples' );
			group: 'Tests' with: #(#'DeepTraverser-Tests' ). ].

]

{ #category : #'symbolic versions' }
ConfigurationOfDeepTraverser >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'pharo4.x' version: '1.2'.

	spec for: #'pharo5.x' version: '2.0'.

	spec for: #'pharo6.x' version: '1.1-baseline'.

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

{ #category : #'symbolic versions' }
ConfigurationOfDeepTraverser >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.2'.

	spec for: #'pharo3.x' version: '1.0'.

	spec for: #'pharo4.x' version: '1.2'.

	spec for: #'pharo5.x' version: '2.0'.

	spec for: #'pharo6.x' version: '2.0'.

]

{ #category : #versions }
ConfigurationOfDeepTraverser >> version10: spec [
	<version: '1.0' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0'.
		spec author: 'StephaneDucasse'.
		spec timestamp: '6/28/2014 19:24'.
		spec package: 'DeepTraverser' with: 'DeepTraverser-TudorGirba.6'. ].

]

{ #category : #versions }
ConfigurationOfDeepTraverser >> version11: spec [
	<version: '1.1' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.1'.
		spec author: 'AndreiChis'.
		spec timestamp: '5/18/2015 00:45'.
		spec package: 'DeepTraverser' with: 'DeepTraverser-StefanReichhart.9'. ].

]

{ #category : #versions }
ConfigurationOfDeepTraverser >> version12: spec [
	<version: '1.2' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.2'.
		spec author: 'TudorGirba'.
		spec timestamp: '7/8/2015 07:45'.
		spec package: 'DeepTraverser' with: 'DeepTraverser-StefanReichhart.10'. ].

]

{ #category : #versions }
ConfigurationOfDeepTraverser >> version20: spec [
	<version: '2.0' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'Moose 6.0 release'.
		spec author: 'PavelKrivanek'.
		spec timestamp: '4/21/2017 10:00'.
		spec package: 'DeepTraverser' with: 'DeepTraverser-PavelKrivanek.41'. ].

]
