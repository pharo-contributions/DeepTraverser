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
		'nodeAction',
		'edgeAction',
		'objectsToTraverse',
		'objectsTraversed',
		'objectsToTraverseAndTraversed',
		'edgesToTraverse'
	],
	#category : #DeepTraverser
}

{ #category : #'accessing-compatibility' }
DeepTraverser >> action [
	self deprecated: 'please use #nodeAction instead'.
	^ self nodeAction
]

{ #category : #'accessing-compatibility' }
DeepTraverser >> action: anObject [
	self deprecated: 'please use #nodeAction: instead'.
	self nodeAction: anObject
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
		whileTrue: [ self next ]
]

{ #category : #private }
DeepTraverser >> doAction [
	start == current ifTrue: [ start == first ifFalse: [ ^ self ] ].
	self nodeAction withIteratorNodeAction: self.
	self edgeAction withIteratorEdgeAction: self
]

{ #category : #private }
DeepTraverser >> doTraverse [
	self traverser withIterator: self traverse: current
]

{ #category : #accessing }
DeepTraverser >> edgeAction [
	^ edgeAction
]

{ #category : #accessing }
DeepTraverser >> edgeAction: anObject [
	edgeAction := anObject
]

{ #category : #private }
DeepTraverser >> edgeFor: anObject [
	^ (edgesToTraverse at: anObject ifAbsent: [ nil ]) -> anObject
]

{ #category : #'public-enumerating' }
DeepTraverser >> edgesDo: aBlock [
	[ self hasNext ] 
		whileTrue: [ self nextEdgeDo: aBlock ]
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
	next := self next.
	^ aBlock 
		value: (edgesToTraverse at: next ifAbsent: [ nil ]) 
		value: next
		
]

{ #category : #'public-streaming' }
DeepTraverser >> nextEdges: anInteger [
	^ (self next: anInteger) collect: [ :each | self edgeFor: each ]
]

{ #category : #accessing }
DeepTraverser >> nodeAction [
	^ nodeAction
]

{ #category : #accessing }
DeepTraverser >> nodeAction: anObject [
	nodeAction := anObject
]

{ #category : #'accessing-convenience' }
DeepTraverser >> objectsTraversed [
	^ objectsTraversed copy
]

{ #category : #'private-double-dispatch' }
DeepTraverser >> performEdgeActionBlock: aBlock [
	aBlock value: ((edgesToTraverse at: current ifAbsent: [ nil ])) value: current 
]

{ #category : #'private-double-dispatch' }
DeepTraverser >> performEdgeActionMessageSend: aMessageSend [
	aMessageSend value: ((edgesToTraverse at: current ifAbsent: [ nil ])) value: current 
]

{ #category : #'private-double-dispatch' }
DeepTraverser >> performEdgeActionSymbol: aSymbol [
	current perform: aSymbol withEnoughArguments: { edgesToTraverse at: current ifAbsent: [ nil ] }
]

{ #category : #'private-double-dispatch' }
DeepTraverser >> performNodeActionBlock: aBlock [
	aBlock value: current
]

{ #category : #'private-double-dispatch' }
DeepTraverser >> performNodeActionMessageSend: aMessageSend [
	aMessageSend value: current
]

{ #category : #'private-double-dispatch' }
DeepTraverser >> performNodeActionSymbol: aSymbol [
	current perform: aSymbol
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

{ #category : #'accessing-convenience' }
DeepTraverser >> traverse: anObject [
	self withStart: anObject.
	self run.
]

{ #category : #'accessing-compatibility' }
DeepTraverser >> traversedObjects [
	self deprecated: 'please use #objectsTraversed instead'.
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

{ #category : #'accessing-convenience' }
DeepTraverser >> withAllStart: aCollection [
	" start traversal including each of aCollection as first nodes being traversed "
	initializer := [ self withAllStart: aCollection ]. " used for streaming/reset "
	
	start := aCollection anyOne.
	first := start.
	current := nil.
	
	objectsToTraverse := OrderedCollection withAll: aCollection. 
	objectsToTraverseAndTraversed := IdentitySet withAll: aCollection. 
	objectsTraversed := IdentitySet new.
	edgesToTraverse := IdentityDictionary new
]

{ #category : #'accessing-convenience' }
DeepTraverser >> withStart: anObject [
	" start traversal including anObject as the first node being traversed. The first edge will be nil -> anObject "
	initializer := [ self withStart: anObject ]. " used for streaming/reset "
	
	start := anObject.
	first := anObject.
	current := nil.
	
	objectsToTraverse := OrderedCollection with: start.
	objectsToTraverseAndTraversed := IdentitySet with: start.
	objectsTraversed := IdentitySet new.
	edgesToTraverse := IdentityDictionary new
]

{ #category : #'accessing-convenience' }
DeepTraverser >> withoutStart: anObject [
	" start traversal excluding anObject as the first node being traversed. The first node will be anObject -> ? "
	initializer := [ self withoutStart: anObject ]. " used for streaming/reset "

	start := anObject.
	first := nil.
	current := nil.
	
	objectsToTraverse := OrderedCollection with: start.
	objectsToTraverseAndTraversed := IdentitySet with: start.
	objectsTraversed := IdentitySet new.
	edgesToTraverse := IdentityDictionary new
]
