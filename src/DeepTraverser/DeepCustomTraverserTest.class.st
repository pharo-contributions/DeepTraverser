"
This is a test class for testing the behavior of DeepTraverser
"
Class {
	#name : #DeepCustomTraverserTest,
	#superclass : #DeepTraverserTest,
	#instVars : [
		'traverser'
	],
	#category : #DeepTraverser
}

{ #category : #running }
DeepCustomTraverserTest >> setUp [
	super setUp.
	traverser := DeepTraverser withCustomTraversal: [ :each | graph at: each ifAbsent: [{ }] ]
]

{ #category : #tests }
DeepCustomTraverserTest >> testCollectionsAreExpanded [
	traverser traverse: 10.
	self 
		assert: traverser traversedObjects 
		equals: {10 . 11} asSet
]

{ #category : #tests }
DeepCustomTraverserTest >> testCycles [
	traverser traverse: 1.
	self 
		assert: traverser traversedObjects 
		equals: { 1 . 2 . 3} asSet
]

{ #category : #tests }
DeepCustomTraverserTest >> testNoCycle [
	traverser traverse: 4.
	self 
		assert: traverser traversedObjects 
		equals: {4 . 3} asSet
]

{ #category : #tests }
DeepCustomTraverserTest >> testOriginIsPresentInResult [
	traverser traverse: 0.
	self 
		assert: traverser traversedObjects 
		equals: {0 . 1 . 2 . 3} asSet
]
