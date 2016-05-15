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
		'objectsToTraverseAndTraversed',
		'edgesToTraverse'
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

{ #category : #'public-streaming' }
DeepTraverser >> current [
	^ current
]

{ #category : #'public-streaming' }
DeepTraverser >> currentEdge [
	^ self edgeFor: current
]

{ #category : #'public-enumerating' }
DeepTraverser >> do: aBlock [
	[ self hasNext ] 
		whileTrue: [ self nextEdgeDo: aBlock ]
]

{ #category : #private }
DeepTraverser >> doAction [
	start == current ifTrue: [ start == first ifFalse: [ ^ self ] ].
	self action withIteratorAction: self 
		from: ((edgesToTraverse at: current ifAbsent: [ nil ])) 
		to: current.
]

{ #category : #private }
DeepTraverser >> doTraverse [
	self traverser withIterator: self traverse: current
]

{ #category : #private }
DeepTraverser >> edgeFor: anObject [
	^ (edgesToTraverse at: anObject ifAbsent: [ nil ]) -> anObject
]

{ #category : #'accessing-convenience' }
DeepTraverser >> edgesTraversed [
	^ objectsTraversed collect: [ :each | self edgeFor: each  ]
]

{ #category : #'public-streaming' }
DeepTraverser >> edgesUpToAny: aCollection [
	^ self upToAnyMatching: [ :to :from | 
		aCollection anySatisfy: [ :assoc | 
			to = assoc value 
				and: [ from = assoc key ] ] ]
]

{ #category : #'public-streaming' }
DeepTraverser >> edgesUpToAnyMatching: aBlock [
	^ (self upToAnyMatching: aBlock) collect: [ :each | 
		self edgeFor: each ]
]

{ #category : #'public-streaming' }
DeepTraverser >> edgesUpToEnd [
	^ self upToEnd collect: [ :each | 
		self edgeFor: each ]
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

{ #category : #'public-streaming' }
DeepTraverser >> nextEdge [
	^ self edgeFor: self next
]

{ #category : #private }
DeepTraverser >> nextEdgeDo: aBlock [
	| next |
	^ aBlock 
		cull: (next := self next) 
		cull: (edgesToTraverse at: next ifAbsent: [ nil ]) 
]

{ #category : #'public-streaming' }
DeepTraverser >> nextEdges: anInteger [
	^ (self next: anInteger) collect: [ :each | self edgeFor: each ]
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
DeepTraverser >> pushForIteration: anObject [
	(objectsToTraverseAndTraversed includes: anObject) ifTrue: [ ^ self ].
	objectsToTraverse add: anObject.
	objectsToTraverseAndTraversed add: anObject.
	edgesToTraverse at: anObject put: current.
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
	[ self hasNext and: [ (self nextEdgeDo: aBlock) not ] ] whileTrue: [ 
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
	edgesToTraverse := IdentityDictionary new.
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
	edgesToTraverse := IdentityDictionary new
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
	edgesToTraverse := IdentityDictionary new.
]
