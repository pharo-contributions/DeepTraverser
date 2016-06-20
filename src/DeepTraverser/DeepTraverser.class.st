Class {
	#name : #DeepTraverser,
	#superclass : #Object,
	#instVars : [
		'object',
		'onNodeAction',
		'onEdgeAction',
		'onNodeTraverse',
		'objectsToTraverse',
		'objectsTraversed',
		'initializer',
		'current',
		'previous',
		'edgesToAction',
		'startAction',
		'startObject',
		'onPickNextAction',
		'isActionAppliedOnCurrent',
		'expectedSize'
	],
	#category : #DeepTraverser
}

{ #category : #deprecated }
DeepTraverser >> action [
	self deprecated: 'please use #onNodeAction instead'.
	^ self onNodeAction
]

{ #category : #deprecated }
DeepTraverser >> action: anAction [
	self deprecated: 'please use #onNodeAction: instead'.
	self onNodeAction: anAction
]

{ #category : #testing }
DeepTraverser >> atEnd [
	^ self hasNext not
]

{ #category : #enumerating }
DeepTraverser >> collect: aBlock [
	^ self collect: aBlock as: OrderedCollection 
]

{ #category : #enumerating }
DeepTraverser >> collect: aBlock as: aCollectionClass [
	| newCollection |
	newCollection := aCollectionClass new.
	self do: [ :each |
		newCollection add: (aBlock value: each) ].
	^ newCollection
]

{ #category : #streaming }
DeepTraverser >> current [
	^ current
]

{ #category : #enumerating }
DeepTraverser >> do: aBlock [
	self reset.
	[ self hasNext ] 
		whileTrue: [ aBlock value: self next ]
]

{ #category : #private }
DeepTraverser >> doNodeAction [
	" the current action phase "
	
	" decide whether to apply action on the first/initial nodes (or not) "
	isActionAppliedOnCurrent ifFalse: [ ^ self ].
	
	" handle the action for the current node "
	onNodeAction action: current using: self.
	
	" handle the actions of postponed edge actions related to the current node "
	(edgesToAction removeKey: current ifAbsent: [ #() ]) do: [ :assoc |
		onEdgeAction from: assoc key to: assoc value using: self ]
	
]

{ #category : #private }
DeepTraverser >> doNodeTraverse [
	" the current traversal phase "
	
	" always traverse a scheduled node "
	onNodeTraverse traverse: current using: self.	

]

{ #category : #accessing }
DeepTraverser >> expectedSize [
	^ expectedSize ifNil: [ expectedSize := 100 ]
]

{ #category : #accessing }
DeepTraverser >> expectedSize: anNumber [
	expectedSize := expectedSize
]

{ #category : #deprecated }
DeepTraverser >> firstObjectAction: anAction [
	self deprecated: 'please use one of the #on:* methods'.
	
]

{ #category : #testing }
DeepTraverser >> hasNext [
	^ objectsToTraverse isEmptyOrNil not
]

{ #category : #private }
DeepTraverser >> isToTraverse: anObject [
	" return true if anObject has not been scheduled/postponed for later traversal and action "
	objectsToTraverse reverseDo: [ :each | 
		each == anObject ifTrue: [ 
			^ true ] ].
	^ false
]

{ #category : #private }
DeepTraverser >> isTraversed: anObject [
	" return true if anObject has already been traversed and action was performed "
	^ objectsTraversed includes: anObject
]

{ #category : #streaming }
DeepTraverser >> next [
	previous := current.
	onPickNextAction value.
	objectsTraversed add: current.
	self doNodeTraverse.
	self doNodeAction.
	^ current
]

{ #category : #streaming }
DeepTraverser >> next: anInteger [
	| index newArray |
	index := 0.
	newArray := Array new: anInteger.
	[ index < anInteger and: [ self hasNext ] ] whileTrue: [ 
		newArray at: (index := index + 1) put: self next ].
	^ newArray copyFrom: 1 to: index	
]

{ #category : #accessing }
DeepTraverser >> objectsTraversed [
	^ objectsTraversed
]

{ #category : #configuring }
DeepTraverser >> on: anObject [
	self with: anObject
]

{ #category : #configuring }
DeepTraverser >> on: anObject1 startWith: anObject2 [
	" traverse anObject, start at anObject2 and include anObject3 "
	initializer := [ self on: anObject1 startWith: anObject2 ].
	
	" reset everything "
	object := anObject1.
	startObject := anObject2.
	onPickNextAction := [ current := objectsToTraverse removeFirst ].
	isActionAppliedOnCurrent := true.
	current := nil.
	previous := nil.
	edgesToAction := IdentityDictionary new: self expectedSize. " track edges until they are allowed to be consumed "
	objectsToTraverse := OrderedCollection with: startObject. " traversal  phase 2 check / slow check [reversed for better speed ], quick add "
	objectsTraversed := IdentitySet new: self expectedSize " traversal phase 1 check / quick check, slow add"
]

{ #category : #configuring }
DeepTraverser >> on: anObject1 startWithout: anObject2 [
	<todo: 'fix all traversals without the starting nodes: #start,#first,#startAction'>
	" traverse anObject, start at anObject2 and include anObject3 "
	initializer := [ self on: anObject1 startWithout: anObject2 ].
	
	" reset everything "
	object := anObject1.
	startObject := anObject2.
	onPickNextAction := [ 
		current := objectsToTraverse removeFirst.
		isActionAppliedOnCurrent notNil
			ifTrue: [ isActionAppliedOnCurrent := true. onPickNextAction := [ current := objectsToTraverse removeFirst ] ]
			ifFalse: [ isActionAppliedOnCurrent := false ] ].
	isActionAppliedOnCurrent := nil.
	current := nil.
	previous := nil.
	edgesToAction := IdentityDictionary new: self expectedSize. " track edges until they are allowed to be consumed "
	objectsToTraverse := OrderedCollection with: startObject. " traversal  phase 2 check / slow check [reversed for better speed ], quick add "
	objectsTraversed := IdentitySet new: self expectedSize " traversal phase 1 check / quick check, slow add"
]

{ #category : #accessing }
DeepTraverser >> onEdgeAction [
	^ onEdgeAction
]

{ #category : #accessing }
DeepTraverser >> onEdgeAction: anObject [
	onEdgeAction := anObject
]

{ #category : #accessing }
DeepTraverser >> onNodeAction [
	^ onNodeAction
]

{ #category : #accessing }
DeepTraverser >> onNodeAction: anObject [
	onNodeAction := anObject
]

{ #category : #accessing }
DeepTraverser >> onNodeTraverse [
	^ onNodeTraverse
]

{ #category : #accessing }
DeepTraverser >> onNodeTraverse: anObject [
	onNodeTraverse := anObject
]

{ #category : #streaming }
DeepTraverser >> position [
	^ objectsTraversed size
]

{ #category : #streaming }
DeepTraverser >> previous [
	^ previous
]

{ #category : #enumerating }
DeepTraverser >> reject: aBlock [
	^ self reject: aBlock as: OrderedCollection 
]

{ #category : #enumerating }
DeepTraverser >> reject: aBlock as: aCollectionClass [
	^ self select: [ :each | (aBlock value: each) not ] as: aCollectionClass
]

{ #category : #streaming }
DeepTraverser >> reset [
	initializer value
]

{ #category : #private }
DeepTraverser >> run [
	self reset.
	[ self hasNext ] 
		whileTrue: [ self next ]
]

{ #category : #enumerating }
DeepTraverser >> select: aBlock [
	^ self select: aBlock as: OrderedCollection 
]

{ #category : #enumerating }
DeepTraverser >> select: aBlock as: aCollectionClass [
	| newCollection |
	newCollection := aCollectionClass new.
	self do: [ :each |
		(aBlock value: each) ifTrue: [ 
			newCollection add: each ] ].
	^ newCollection
]

{ #category : #private }
DeepTraverser >> traverse: anObject [
	(self isTraversed: anObject) ifTrue: [ 
		" this node has already been traversed, but the edge still needs to be handled in the following action-phase "
		(edgesToAction at: current ifAbsentPut: [ OrderedCollection new ]) add: (current -> anObject).
		^ self ].
	
	(self isToTraverse: anObject) ifTrue: [ 
		" this node is already scheduled/postponed for traversal, we store the edge for later (traversal-phase + action-phase are still coming) "
		(edgesToAction at: anObject ifAbsentPut: [ OrderedCollection new ]) add: (current -> anObject).
		^ self ].
	
	" add this new node for the next traversal. adding must be at the end of the collection otherwise onPickNextAction/isActionAppliedOnCurrent will be corrupt "
	objectsToTraverse add: anObject.
	
	" schedule/postpone this new node for the following action-phase "
	(edgesToAction at: anObject ifAbsentPut: [ OrderedCollection new ]) add: (current -> anObject).
		
]

{ #category : #deprecated }
DeepTraverser >> traversedObjects [
	self deprecated: 'please use #objectsTraversed instead'.
	^ self objectsTraversed
]

{ #category : #deprecated }
DeepTraverser >> traverser [
	self deprecated: 'please use #onNodeTraverse instead'.
	^ self onNodeTraverse
]

{ #category : #deprecated }
DeepTraverser >> traverser: aBlock [
	self deprecated: 'please use #onNodeTraverse: instead'.
	self onNodeTraverse: aBlock
]

{ #category : #streaming }
DeepTraverser >> upTo: anObject [
	| newArray |
	newArray := OrderedCollection new.
	[ self hasNext and: [ (self next = anObject) not ] ] whileTrue: [ 
		newArray add: current ].
	^ newArray
]

{ #category : #streaming }
DeepTraverser >> upToAny: aCollection [
	^ self upToAnyMatching: [ :each | aCollection includes: each ]
]

{ #category : #streaming }
DeepTraverser >> upToAnyMatching: aBlock [
	| newArray |
	newArray := OrderedCollection new.
	[ self hasNext and: [ (aBlock value: self next) not ] ] whileTrue: [ 
		newArray add: current ].
	^ newArray
]

{ #category : #streaming }
DeepTraverser >> upToEnd [
	| newArray |
	newArray := OrderedCollection new.
	[ self hasNext ] whileTrue: [ 
		newArray add: self next ].
	^ newArray
]

{ #category : #configuring }
DeepTraverser >> with: anObject [
	self on: anObject startWith: anObject
]

{ #category : #configuring }
DeepTraverser >> withAll: aCollection [
	" traverse anObject, start at anObject2 and include anObject3 "
	initializer := [ self withAll: aCollection ].
	
	" reset everything "
	object := aCollection.
	
	startObject := aCollection copy.
	onPickNextAction := [ current := objectsToTraverse removeFirst ].
	isActionAppliedOnCurrent := true.
	current := nil.
	previous := nil.
	edgesToAction := IdentityDictionary new: self expectedSize. " track edges until they are allowed to be consumed "
	objectsToTraverse := OrderedCollection withAll: startObject. " traversal  phase 2 check / slow check [reversed for better speed ], quick add "
	objectsTraversed := IdentitySet new: self expectedSize " traversal phase 1 check / quick check, slow add"
]

{ #category : #configuring }
DeepTraverser >> without: anObject [
	<todo: 'fix all traversals without the starting nodes: #start,#first,#startAction'>
	self on: anObject startWithout: anObject
]

{ #category : #configuring }
DeepTraverser >> withoutAll: aCollection [
	<todo: 'fix all traversals without the starting nodes: #start,#first,#startAction'>
	" traverse anObject, start at anObject2 and include anObject3 "
	initializer := [ self withoutAll: aCollection ].
	
	" reset everything "
	object := aCollection asOrderedCollection.
	startObject := aCollection asOrderedCollection.
	onPickNextAction := [ 
		current := objectsToTraverse removeFirst.
		startObject isEmpty
			ifTrue: [ isActionAppliedOnCurrent := true. onPickNextAction := [ current := objectsToTraverse removeFirst ] ]
			ifFalse: [ isActionAppliedOnCurrent := false. startObject removeFirst. ] ].
	isActionAppliedOnCurrent := nil.
	current := nil.
	previous := nil.
	edgesToAction := IdentityDictionary new: self expectedSize. " track edges until they are allowed to be consumed "
	objectsToTraverse := OrderedCollection withAll: startObject. " traversal  phase 2 check / slow check [reversed for better speed ], quick add "
	objectsTraversed := IdentitySet new: self expectedSize " traversal phase 1 check / quick check, slow add"
]
