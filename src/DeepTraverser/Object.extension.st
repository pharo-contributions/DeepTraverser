Extension { #name : #Object }

{ #category : #'*DeepTraverser' }
Object >> deep: aTraversalBlock collect: aCollectBlock [
	"traverses all objects starting with the receiver using aTraversalBlock, and
	for each triggers aCollectBlock and adds it to the returned OrderedCollection.
	
	For example:
	Number
		deep: #subclasses 
		collect: #name"

	^ self 
		deep: aTraversalBlock 
		collect: aCollectBlock 
		as: OrderedCollection
]

{ #category : #'*DeepTraverser' }
Object >> deep: aTraversalBlock collect: aCollectBlock as: aCollectionClass [
	"traverses all objects starting with the receiver using aTraversalBlock, and
	for each triggers aCollectBlock and adds it to the returned collection
	that is of type aCollectionClass.
	
	For example:
	Number
		deep: #subclasses 
		collect: #name
		as: Set"

	| result |
	result := aCollectionClass new.
	self 
		deep: aTraversalBlock 
		do: [ :each | result add: (aCollectBlock value: each) ].
	^ result
]

{ #category : #'*DeepTraverser' }
Object >> deep: aTraversalBlock do: anObjectActionBlock [
	"traverses all objects starting with the receiver using aTraversalBlock, and
	for each triggers anObjectActionBlock.
	
	For example:
	Number
		deep: #subclasses 
		do: [:each | Transcript show: each; cr]"
	
	(DeepTraverser new 
		withoutStart: self;
		traverser: aTraversalBlock;
		performer: anObjectActionBlock;
		yourself) run
]

{ #category : #'*DeepTraverser' }
Object >> deep: aTraversalBlock flatCollect: aCollectBlock [
	"traverses all objects starting with the receiver using aTraversalBlock, and
	for each triggers aCollectBlock and adds the objects from the collection
	to the returned OrderedCollection.
	
	For example:
	Number
		deep: #subclasses 
		flatCollect: #selectors"
		
	^ self 
		deep: aTraversalBlock 
		flatCollect: aCollectBlock 
		as: OrderedCollection
]

{ #category : #'*DeepTraverser' }
Object >> deep: aTraversalBlock flatCollect: aCollectBlock as: aCollectionClass [
	"traverses all objects starting with the receiver using aTraversalBlock, and
	for each triggers aCollectBlock and adds the objects from the collection
	to the returned instance of aCollectionClass.
	
	For example:
	Number
		deep: #subclasses 
		flatCollect: #selectors
		as: Set"
	
	| result |
	result := aCollectionClass new.
	self 
		deep: aTraversalBlock 
		do: [ :each | result addAll: (aCollectBlock value: each) ].
	^ result
]

{ #category : #'*DeepTraverser' }
Object >> deepCollect: aTraversalBlock [
	"traverses all objects starting with the receiver using aTraversalBlock, and
	returns an OrderedCollection containing each traversed object.
	
	For example:
	Number deepCollect: #subclasses"
	
	^ self 
		deep: aTraversalBlock 
		collect: [ :each | each ]
]

{ #category : #'*DeepTraverser' }
Object >> deepCollectAsSet: aBlock [
	"traverses all objects starting with the receiver using aTraversalBlock, and
	returns a Set containing each traversed object.
	
	For example:
	Number deepCollectAsSet: #subclasses"

	"When the desired result is a set, we take advantage of the 
	fact that the traversed objects are kept in a set inside the traverser
	and we simply return that set"
	
	^ self 
		deep: aBlock 
		collect: [ :each | each ]
		as: Set
]

{ #category : #'*DeepTraverser-private' }
Object >> pushForIterator: anIterator [
	anIterator pushForIteration: self
]

{ #category : #'*DeepTraverser' }
Object >> withDeep: aBlock1 collect: aBlock2 [
	^ self 
		withDeep: aBlock1 
		collect: aBlock2 
		as: OrderedCollection 
]

{ #category : #'*DeepTraverser' }
Object >> withDeep: aBlock1 collect: aBlock2 as: aClass [
	| result |
	result := aClass new.
	self 
		withDeep: aBlock1 
		do: [ :each | result add: (aBlock2 value: each) ].
	^ result.
]

{ #category : #'*DeepTraverser' }
Object >> withDeep: aTraversalBlock do: anObjectActionBlock [
	"traverses all objects starting with and including the receiver using aTraversalBlock, and
	for each triggers anObjectActionBlock.
	
	For example:
	Number
		withDeep: #subclasses 
		do: [:each | Transcript show: each]"

	(DeepTraverser new 
		withStart: self;
		traverser: aTraversalBlock;
		performer: anObjectActionBlock;
		yourself) run
]

{ #category : #'*DeepTraverser' }
Object >> withDeep: aTraversalBlock flatCollect: aCollectBlock [
	"traverses all objects starting with and including the receiver using aTraversalBlock, and
	for each triggers aCollectBlock and adds the objects from the collection
	to the returned OrderedCollection.
	
	For example:
	Number
		deep: #subclasses 
		flatCollect: #selectors"
		
	^ self 
		withDeep: aTraversalBlock 
		flatCollect: aCollectBlock 
		as: OrderedCollection
]

{ #category : #'*DeepTraverser' }
Object >> withDeep: aTraversalBlock flatCollect: aCollectBlock as: aCollectionClass [
	"traverses all objects starting with and including the receiver using aTraversalBlock, and
	for each triggers aCollectBlock and adds the objects from the collection
	to the returned instance of aCollectionClass.
	
	For example:
	Number
		deep: #subclasses 
		flatCollect: #selectors
		as: Set"
	
	| result |
	result := aCollectionClass new.
	self 
		withDeep: aTraversalBlock 
		do: [ :each | result addAll: (aCollectBlock value: each) ].
	^ result
]

{ #category : #'*DeepTraverser' }
Object >> withDeep: aBlock1 select: aBlock2 collect: aBlock3 [
	^ self 
		withDeep: aBlock1 
		select: aBlock2 
		collect: aBlock3 
		as: OrderedCollection 
]

{ #category : #'*DeepTraverser' }
Object >> withDeep: aBlock1 select: aBlock2 collect: aBlock3 as: aClass [
	| result |
	result := aClass new.
	self 
		withDeep: aBlock1 
		do: [ :each | (aBlock2 value: each) 
			ifTrue: [ result add: (aBlock3 value: each) ] ].
	^ result.
]

{ #category : #'*DeepTraverser' }
Object >> withDeepCollect: aTraversalBlock [
	"traverses all objects starting with and including the receiver using aTraversalBlock, and
	returns an OrderedCollection containing each traversed object.
	
	For example:
	Number withDeepCollect: #subclasses"

	^ self 
		withDeep: aTraversalBlock 
		collect: [ :each | each ]
]

{ #category : #'*DeepTraverser' }
Object >> withDeepCollect: aBlock1 select: aBlock2 [
	^ self 
		withDeep: aBlock1 
		select: aBlock2 
		collect: [ :each | each ]
]
