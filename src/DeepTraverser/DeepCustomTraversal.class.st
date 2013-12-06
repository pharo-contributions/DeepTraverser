"
This class simply defines the traversal through a block that gets executed for each object
"
Class {
	#name : #DeepCustomTraversal,
	#superclass : #DeepTraversal,
	#instVars : [
		'traversalBlock'
	],
	#category : #DeepTraverser
}

{ #category : #'instance creation' }
DeepCustomTraversal class >> with: aBlock [
	^ self new 
		traversalBlock: aBlock
]

{ #category : #private }
DeepCustomTraversal >> objectsToTraverseFrom: anObject do: aBlock [
	^ (traversalBlock value: anObject) asOrderedCollection do: aBlock
]

{ #category : #accessing }
DeepCustomTraversal >> traversalBlock: aBlock [
	traversalBlock := aBlock
]
