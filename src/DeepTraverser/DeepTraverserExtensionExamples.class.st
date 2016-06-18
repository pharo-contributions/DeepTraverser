Class {
	#name : #DeepTraverserExtensionExamples,
	#superclass : #Object,
	#category : #'DeepTraverser-Examples'
}

{ #category : #'*DeepTraverser-Examples' }
DeepTraverserExtensionExamples class >> gtExamplesProvider [
	^ DeepTraverserExtensionExamples new 
]

{ #category : #'*DeepTraverser-Examples' }
DeepTraverserExtensionExamples class >> gtExamplesSource [
	^ DeepTraverser
]

{ #category : #examples }
DeepTraverserExtensionExamples >> deepCollect: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		collect: [ :each | each * 10 ].
	self assert: result = #( 20 30 ) asOrderedCollection
]

{ #category : #examples }
DeepTraverserExtensionExamples >> deepCollectAs: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		collect: [ :each | each * 10 ]
		as: Set.
	self assert: result = #( 20 30 ) asSet
]

{ #category : #examples }
DeepTraverserExtensionExamples >> deepCollectAsSet: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		deepCollectAsSet: [ :each | self nextElementsFor: each inGraph: graph ].
	self assert: result = #( 2 3 ) asSet
]

{ #category : #examples }
DeepTraverserExtensionExamples >> deepCollectSimple: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		deepCollect: [ :each | self nextElementsFor: each inGraph: graph].
	self assert: result = #( 2 3 ) asOrderedCollection
]

{ #category : #examples }
DeepTraverserExtensionExamples >> deepDo: graph [
	<gtExample>
	<depends: #graph1>
	
	| trace |
	trace := OrderedCollection new.
	1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		do: [ :each | trace add: each ].
	self assert: trace = #( 2 3 ) asOrderedCollection
]

{ #category : #examples }
DeepTraverserExtensionExamples >> deepDoRelationDo: graph [
	<gtExample>
	<depends: #graph1>
	
	| trace relationTrace |
	trace := OrderedCollection new.
	relationTrace := OrderedCollection new.
	1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		do: [ :each | trace add: each ]
		relationDo: [ :from :to | relationTrace add: from->to ].
	self assert: trace = #( 2 3 ) asOrderedCollection.
	self assert: relationTrace = { 1->2 . 1->3 . 2->3 } asOrderedCollection

]

{ #category : #examples }
DeepTraverserExtensionExamples >> deepEdgesDo: graph [
	<gtExample>
	<depends: #graph1>
	
	| trace |
	trace := OrderedCollection new.
	1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		edgesDo: [ :from :to | trace add: (from -> to) ].
	self assert: trace = { 1->2. 1->3. 2->3 } asOrderedCollection
]

{ #category : #examples }
DeepTraverserExtensionExamples >> deepFlatCollect: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		flatCollect: [ :each | 1 to: each ].
	self assert: result = #( 1 2 1 2 3 ) asOrderedCollection
]

{ #category : #examples }
DeepTraverserExtensionExamples >> deepFlatCollectAs: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		flatCollect: [ :each | 1 to: each ]
		as: Set.
	self assert: result = #( 1 2 3 ) asSet
]

{ #category : #examples }
DeepTraverserExtensionExamples >> deepRelationDo: graph [
	<todo: 'is this really what we want ?'>
	<gtExample>
	<depends: #graph1>
	
	| relationTrace |
	relationTrace := OrderedCollection new.
	1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		relationDo: [ :from :to | relationTrace add: from->to ].
	self assert: relationTrace = { 1->2 . 1->3 . 2->3 } asOrderedCollection

]

{ #category : #examples }
DeepTraverserExtensionExamples >> deepSelect: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		select: [ :each | each < 3 ].
	self assert: result = #( 2 ) asOrderedCollection
]

{ #category : #examples }
DeepTraverserExtensionExamples >> deepSelectCollectAs: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		select: [ :each | each odd ]
		collect: [ :each | each ]
		as: Set.
	self assert: result = #( 3 ) asSet
]

{ #category : #data }
DeepTraverserExtensionExamples >> graph1 [
	<gtExample>
	| graph |
	graph := Dictionary new.
	graph at: 0 put: { 1 }.
	graph at: 1 put: { 2 . 3 }.
	graph at: 2 put: { 3 }.
	graph at: 4 put: { 3 }.
	graph at: 10 put: { 11 }.
	^ graph
]

{ #category : #utils }
DeepTraverserExtensionExamples >> nextElementsFor: each inGraph: graph [
	^ graph at: each ifAbsent: [ #() ]
]

{ #category : #examples }
DeepTraverserExtensionExamples >> withDeepCollect: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		withDeepCollect: [ :each | self nextElementsFor: each inGraph: graph ].
	self assert: result = #( 1 2 3 ) asOrderedCollection
]

{ #category : #examples }
DeepTraverserExtensionExamples >> withDeepCollectAs: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		withDeepCollect: [ :each | self nextElementsFor: each inGraph: graph ]
		as: Set.
	self assert: result asSet = #( 1 2 3 ) asSet
]

{ #category : #examples }
DeepTraverserExtensionExamples >> withDeepDo: graph [
	<gtExample>
	<depends: #graph1>
	
	| trace |
	trace := OrderedCollection new.
	1 
		withDeep: [ :each | self nextElementsFor: each inGraph: graph ] 
		do: [ :each | trace add: each ].
	self assert: trace = #( 1 2 3 ) asOrderedCollection
]

{ #category : #examples }
DeepTraverserExtensionExamples >> withDeepDoRelationDo: graph [
	<gtExample>
	<depends: #graph1>
	
	| trace relationTrace |
	trace := OrderedCollection new.
	relationTrace := OrderedCollection new.

	1 
		withDeep: [ :each | self nextElementsFor: each inGraph: graph ] 
		do: [ :each | trace add: each ]
		relationDo: [ :from :to | relationTrace add: from->to ].
	self assert: trace = #( 1 2 3 ) asOrderedCollection.
	self assert: relationTrace = { 1->2 . 1->3 . 2->3 } asOrderedCollection
]

{ #category : #examples }
DeepTraverserExtensionExamples >> withDeepEdgesDo: graph [
	<gtExample>
	<depends: #graph1>
	
	| trace |
	trace := OrderedCollection new.
	0 
		withDeep: [ :each | self nextElementsFor: each inGraph: graph ] 
		edgesDo: [ :from :to | trace add: (from -> to) ].
	self assert: trace = { 0->1. 1->2. 1->3. 2->3 } asOrderedCollection
]

{ #category : #examples }
DeepTraverserExtensionExamples >> withDeepFlatCollect: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		withDeep: [ :each | self nextElementsFor: each inGraph: graph ]
		flatCollect: [ :each | each to: 4 ].
	self assert: result = #( 1 2 3 4 2 3 4 3 4 ) asOrderedCollection
]

{ #category : #examples }
DeepTraverserExtensionExamples >> withDeepFlatCollectAs: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		withDeep: [ :each | self nextElementsFor: each inGraph: graph ]
		flatCollect: [ :each | each to: 4 ]
		as: Set.
	self assert: result = #( 1 2 3 4 2 3 4 3 4 ) asSet
]

{ #category : #examples }
DeepTraverserExtensionExamples >> withDeepRelationDo: graph [
	<gtExample>
	<depends: #graph1>
	
	| relationTrace |
	relationTrace := OrderedCollection new.

	1 
		withDeep: [ :each | self nextElementsFor: each inGraph: graph ] 
		relationDo: [ :from :to | relationTrace add: from->to ].
	self assert: relationTrace = { 1->2 . 1->3 . 2->3 } asOrderedCollection.
]

{ #category : #examples }
DeepTraverserExtensionExamples >> withDeepSelectCollect: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		withDeep: [ :each | self nextElementsFor: each inGraph: graph ]
		select: [ :each | each odd ]
		collect: [ :each | each * 10 ].
	self assert: result = #( 10 30 ) asOrderedCollection
]

{ #category : #examples }
DeepTraverserExtensionExamples >> withDeepSelectCollectAs: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		withDeep: [ :each | self nextElementsFor: each inGraph: graph ]
		select: [ :each | each odd ]
		collect: [ :each | each ]
		as: Set.
	self assert: result = #( 1 3 ) asSet
]
