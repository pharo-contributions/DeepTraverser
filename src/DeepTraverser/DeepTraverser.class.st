"
The traverser has three responsibilities:
1. traverse objects,
2. mark traversed objects,
3. trigger actions for each traversed object and each relation between two traversed objects

1. is handled via  the DeepTraversal hierarchy
2. is the responsibility of the traverse itself
3. is handled by the DeepActionStrategy hierarchy
"
Class {
	#name : #DeepTraverser,
	#superclass : #Object,
	#instVars : [
		'traversed',
		'traversal',
		'action',
		'firstObjectAction',
		'toTraverse'
	],
	#category : #DeepTraverser
}

{ #category : #'instance creation' }
DeepTraverser class >> withCustomTraversal: aBlock [
	"we provide a utility method for handling block traversals
	given that this is likely to be the most common use case"
	^ self new 
		traversal: (DeepCustomTraversal with: aBlock)
]

{ #category : #private }
DeepTraverser >> actOnFirstObject: anObject [
	^ firstObjectAction executeOnObject: anObject
]

{ #category : #private }
DeepTraverser >> actOnObject: anObject [
	^ action executeOnObject: anObject
]

{ #category : #private }
DeepTraverser >> actOnRelationFrom: originObject to: targetObject [
	^ self action executeOnRelationFrom: originObject to: targetObject
]

{ #category : #accessing }
DeepTraverser >> action [
	^ action
]

{ #category : #accessing }
DeepTraverser >> action: anAction [
	action := anAction
]

{ #category : #private }
DeepTraverser >> doTraverse: anObject [
	"This method performs the actual traversal and markes the traversed objects.
	It does not make use of recursion to limit problems related to the stack
	when traversing large graphs.
	The logic ignores collections and nil.
	It uses two hooks for triggering custom behavior for each object,
	and each relation between two objects."
	| currentObject |

	toTraverse := OrderedCollection with: anObject.

	 [ toTraverse isEmpty ] whileFalse: [
			currentObject := toTraverse removeFirst.
			traversed add: currentObject.
			self
				objectsToTraverseWithoutCollectionsFrom: currentObject
				do: [ :each | 
					( self shouldTraverse: each ) ifTrue: [ 
								toTraverse add: each.
								self actOnObject: each.
								self actOnRelationFrom: currentObject to: each ] ] ] 
]

{ #category : #accessing }
DeepTraverser >> firstObjectAction [
	^ firstObjectAction
]

{ #category : #accessing }
DeepTraverser >> firstObjectAction: anAction [
	firstObjectAction := anAction
]

{ #category : #initialization }
DeepTraverser >> initialize [ 
	traversed := IdentitySet new.
	toTraverse := OrderedCollection new. "the order of the objects to traverse matters"
	action := DeepNullActionStrategy new.
	firstObjectAction := DeepNullActionStrategy new
]

{ #category : #private }
DeepTraverser >> objectsToTraverseFrom: anObject do: aBlock [	
	^ self traversal objectsToTraverseFrom: anObject do: aBlock
]

{ #category : #private }
DeepTraverser >> objectsToTraverseWithoutCollectionsFrom: anObject do: aBlock [
	self objectsToTraverseFrom: anObject do: [ :eachObject |
		eachObject isCollection 
			ifTrue: [ 
					"we ignore collections"
					eachObject do: [ :each | 
						aBlock value: each.
						self 
							objectsToTraverseWithoutCollectionsFrom: each 
							do: aBlock ] ]
			ifFalse: [ aBlock value: eachObject ] ]
]

{ #category : #private }
DeepTraverser >> shouldTraverse: anObject [
	^ anObject notNil and: [
		(traversed includes: anObject) not and: [
			"we want to avoid marking objects toTraverse multiple
			times before actually traversing them" 
			(toTraverse includes: anObject) not ] ]
]

{ #category : #accessing }
DeepTraverser >> traversal [
	^ traversal
]

{ #category : #accessing }
DeepTraverser >> traversal: aBlock [
	traversal := aBlock
]

{ #category : #'public interface' }
DeepTraverser >> traverse: anObject [
	"This is the main public method that
	starts the traversal and associated logic"
	self actOnFirstObject: anObject.
	self doTraverse: anObject.
	^ self traversedObjects
]

{ #category : #accessing }
DeepTraverser >> traversedObjects [
	^ traversed
]
