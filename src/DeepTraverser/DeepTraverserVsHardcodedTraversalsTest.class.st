Class {
	#name : #DeepTraverserVsHardcodedTraversalsTest,
	#superclass : #DeepTraverserTest,
	#category : #'DeepTraverser-Tests'
}

{ #category : #testing }
DeepTraverserVsHardcodedTraversalsTest >> testSubclassesOfMultipleClasses [
	self 
		assert: ({ Collection . Exception } deepCollect: #subclasses as: Set) size
		equals: (Collection allSubclasses , Exception allSubclasses) asSet size
]

{ #category : #testing }
DeepTraverserVsHardcodedTraversalsTest >> testSubclassesOfOneClass [
	self 
		assert: (Collection deepCollect: #subclasses as: Set) size
		equals: Collection allSubclasses size
]

{ #category : #testing }
DeepTraverserVsHardcodedTraversalsTest >> testSubclassesOfOneClassInAnArray [
	self 
		assert: ({ Collection } deepCollect: #subclasses as: Set) size
		equals: Collection allSubclasses size
]
