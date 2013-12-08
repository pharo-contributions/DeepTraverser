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
DeepCustomTraverserTest >> testFirstObjectAction [
	| objects action |
	objects := OrderedCollection new.
	action := DeepCustomActionStrategy new 
					objectAction: [ :each | objects add: each ].
	traverser action: action.
	traverser firstObjectAction: action.
	traverser traverse: 0.
	self assert: objects size equals: 4.
	self assert: objects equals: { 0. 1 . 2 . 3 } asOrderedCollection
]

{ #category : #tests }
DeepCustomTraverserTest >> testNoCycle [
	traverser traverse: 4.
	self 
		assert: traverser traversedObjects 
		equals: {4 . 3} asSet
]

{ #category : #tests }
DeepCustomTraverserTest >> testObjectAction [
	| objects action |
	objects := OrderedCollection new.
	action := DeepCustomActionStrategy new 
					objectAction: [ :each | objects add: each ].
	traverser action: action.
	traverser traverse: 0.
	self assert: objects size equals: 3.
	self assert: objects equals: { 1 . 2 . 3 } asOrderedCollection
]

{ #category : #tests }
DeepCustomTraverserTest >> testOriginIsPresentInResult [
	traverser traverse: 0.
	self 
		assert: traverser traversedObjects 
		equals: {0 . 1 . 2 . 3} asSet
]

{ #category : #tests }
DeepCustomTraverserTest >> testRelationAction [
	| relations action |
	relations := OrderedCollection new.
	action := DeepCustomActionStrategy new 
					relationAction: [:from :to | relations add: from->to ].
	traverser action: action.
	traverser traverse: 0.
	self assert: relations size equals: 4.
	self assert: relations equals: { 0->1 . 1->2 . 1->3 . 2->3 } asOrderedCollection
]
