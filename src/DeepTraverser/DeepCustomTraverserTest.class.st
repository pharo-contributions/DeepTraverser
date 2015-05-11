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
	traverser := DeepTraverser new
		traverser: [ :each | graph at: each ifAbsent: [{ }] ];
		yourself
]

{ #category : #tests }
DeepCustomTraverserTest >> testCycles [
	traverser withStart: 1; run.
	self 
		assert: traverser traversedObjects 
		equals: { 1 . 2 . 3} asSet
]

{ #category : #tests }
DeepCustomTraverserTest >> testFirstObjectAction [
	| objects  |
	objects := OrderedCollection new.
	traverser withStart: 0.
	traverser action: [ :each | objects add: each ].
	traverser run.
	self assert: objects size equals: 4.
	self assert: objects equals: { 0 . 1 . 2 . 3 } asOrderedCollection
]

{ #category : #tests }
DeepCustomTraverserTest >> testNoCycle [
	traverser withStart: 4; run.
	self 
		assert: traverser traversedObjects 
		equals: {4 . 3} asSet
]

{ #category : #tests }
DeepCustomTraverserTest >> testObjectAction [
	| objects |
	objects := OrderedCollection new.
	traverser withoutStart: 0.
	traverser action: [ :each | objects add: each ].
	traverser run.
	self assert: objects size equals: 3.
	self assert: objects equals: { 1 . 2 . 3 } asOrderedCollection
]

{ #category : #tests }
DeepCustomTraverserTest >> testOriginIsPresentInResult [
	traverser withStart: 0; run.
	self 
		assert: traverser traversedObjects 
		equals: {0 . 1 . 2 . 3} asSet
]
