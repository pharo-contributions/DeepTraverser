Class {
	#name : #DeepTraverser,
	#superclass : #Object,
	#instVars : [
		'initializer',
		'first',
		'start',
		'previous',
		'current',
		'traverser',
		'action',
		'objectsToTraverse',
		'objectsTraversed',
		'objectsToTraverseAndTraversed'
	],
	#category : #DeepTraverser
}

{ #category : #accessing }
DeepTraverser >> action [
	^ action
]

{ #category : #accessing }
DeepTraverser >> action: anObject [
	action := anObject
]

{ #category : #testing }
DeepTraverser >> atEnd [
	^ self hasNext not
]

{ #category : #'accessing-convenience' }
DeepTraverser >> current [
	^ current
]

{ #category : #'public-enumerating' }
DeepTraverser >> do: aBlock [
	[ self hasNext ] 
		whileTrue: [ aBlock value: self next ]
]

{ #category : #private }
DeepTraverser >> doAction [
	start == current ifTrue: [ start == first ifFalse: [ ^ self ] ].
	self action withIterator: self action: current.
]

{ #category : #private }
DeepTraverser >> doTraverse [
	self traverser withIterator: self traverse: current
]

{ #category : #testing }
DeepTraverser >> hasNext [
	^ objectsToTraverse isEmptyOrNil not
]

{ #category : #'public-streaming' }
DeepTraverser >> next [
	current := objectsToTraverse removeFirst.
	objectsTraversed add: current.
	self doTraverse.
	self doAction.
	^ current
]

{ #category : #'public-streaming' }
DeepTraverser >> next: anInteger [
	| index newArray |
	index := 0.
	newArray := Array new: anInteger.
	[ index < anInteger and: [ self hasNext ] ] whileTrue: [ 
		newArray at: (index := index + 1) put: self next ].
	^ newArray copyFrom: 1 to: index	
]

{ #category : #'accessing-convenience' }
DeepTraverser >> objectsTraversed [
	^ objectsTraversed copy
]

{ #category : #'public-streaming' }
DeepTraverser >> position [
	^ objectsTraversed size
]

{ #category : #private }
DeepTraverser >> pushAllForIteration: anObject [
	anObject do: [ :each | 
		self pushForIteration: each ]
]

{ #category : #private }
DeepTraverser >> pushForIteration: anObject [
	(objectsToTraverseAndTraversed includes: anObject) ifTrue: [ ^ self ].
	objectsToTraverse add: anObject.
	objectsToTraverseAndTraversed add: anObject
]

{ #category : #'public-streaming' }
DeepTraverser >> reset [
	initializer value
]

{ #category : #'public-enumerating' }
DeepTraverser >> run [
	[ self hasNext ] 
		whileTrue: [ self next ]
]

{ #category : #'accessing-compatibility' }
DeepTraverser >> traverse: anObject [
	self withStart: anObject.
	self run.
]

{ #category : #'accessing-compatibility' }
DeepTraverser >> traversedObjects [
	^ self objectsTraversed
]

{ #category : #accessing }
DeepTraverser >> traverser [
	^ traverser
]

{ #category : #accessing }
DeepTraverser >> traverser: anObject [
	traverser := anObject
]

{ #category : #'public-streaming' }
DeepTraverser >> upTo: anObject [
	| newArray |
	newArray := OrderedCollection new.
	[ self hasNext and: [ (self next = anObject) not ] ] whileTrue: [ 
		newArray add: current ].
	^ newArray
]

{ #category : #'public-streaming' }
DeepTraverser >> upToAny: aCollection [
	^ self upToAnyMatching: [ :each | aCollection includes: each ]
]

{ #category : #'public-streaming' }
DeepTraverser >> upToAnyMatching: aBlock [
	| newArray |
	newArray := OrderedCollection new.
	[ self hasNext and: [ (aBlock value: self next) not ] ] whileTrue: [ 
		newArray add: current ].
	^ newArray
]

{ #category : #'public-streaming' }
DeepTraverser >> upToEnd [
	| newArray |
	newArray := OrderedCollection new.
	[ self hasNext ] whileTrue: [ 
		newArray add: self next ].
	^ newArray
]

{ #category : #accessing }
DeepTraverser >> withAllStart: aCollection [
	initializer := [ self withAllStart: aCollection ].
	
	start := aCollection anyOne.
	first := start.
	current := nil.
	
	objectsToTraverse := OrderedCollection withAll: aCollection. 
	objectsToTraverseAndTraversed := IdentitySet withAll: aCollection. 
	objectsTraversed := IdentitySet new.
]

{ #category : #accessing }
DeepTraverser >> withStart: anObject [
	initializer := [ self withStart: anObject ].
	
	start := anObject.
	first := anObject.
	current := nil.
	
	objectsToTraverse := OrderedCollection with: start.
	objectsToTraverseAndTraversed := IdentitySet with: start.
	objectsTraversed := IdentitySet new.
]

{ #category : #accessing }
DeepTraverser >> withoutStart: anObject [
	initializer := [ self withoutStart: anObject ].

	start := anObject.
	first := nil.
	current := nil.
	
	objectsToTraverse := OrderedCollection with: start.
	objectsToTraverseAndTraversed := IdentitySet with: start.
	objectsTraversed := IdentitySet new.
	
]
