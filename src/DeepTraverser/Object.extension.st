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
	
	| traverser action |
	action := DeepCustomActionStrategy new objectAction: anObjectActionBlock.
	traverser := DeepTraverser withCustomTraversal: aTraversalBlock.
	traverser 
		action: action;
		traverse: self
]

{ #category : #'*DeepTraverser' }
Object >> deep: aTraversalBlock do: anObjectActionBlock edgesDo: aRelationBlock [
	self deep: aTraversalBlock do: anObjectActionBlock relationDo: aRelationBlock
]

{ #category : #'*DeepTraverser' }
Object >> deep: aTraversalBlock do: anObjectActionBlock relationDo: aRelationBlock [
	"traverses all objects starting with the receiver using aTraversalBlock, and
	for each triggers anObjectActionBlock, and
	for each relation between two traversed objects triggers aRelationBlock.
	
	For example:
	Number 
		deep: #subclasses 
		do: [:each | Transcript show: each; cr]
		relationDo: [ :from :to | Transcript show: from; show: ' <-- '; show: to; cr ]"

	| traverser action |
	action := DeepCustomActionStrategy new 
					objectAction: anObjectActionBlock;
					relationAction: aRelationBlock.
	traverser := DeepTraverser withCustomTraversal: aTraversalBlock.
	traverser 
		action: action;
		traverse: self
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
Object >> deep: aBlock1 select: aBlock2 [
	^ self 
		withDeep: aBlock1 
		select: aBlock2 
		collect: [ :each | each ] 
		as: OrderedCollection
]

{ #category : #'*DeepTraverser' }
Object >> deep: aBlock1 select: aBlock2 collect: aBlock3 as: aClass [
	| result |
	result := aClass new.
	self 
		deep: aBlock1 
		do: [ :each | (aBlock2 value: each) 
			ifTrue: [ result add: (aBlock3 value: each) ] ].
	^ result.
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
Object >> deepCollect: aBlock as: aCollectionClass [
	"traverses all objects starting with the receiver using aTraversalBlock, and
	returns a aCollectionClass containing each traversed object.
	
	For example:
	Number deepCollect: #subclasses as: Set"
	
	^ self 
		deep: aBlock 
		collect: [ :each | each ]
		as: aCollectionClass
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
	
	^ ((DeepTraverser withCustomTraversal: aBlock)
		traverse: self)
		remove: self;
		yourself
]

{ #category : #'*DeepTraverser' }
Object >> withDeep: aTraversalBlock do: anObjectActionBlock [
	"traverses all objects starting with and including the receiver using aTraversalBlock, and
	for each triggers anObjectActionBlock.
	
	For example:
	Number
		withDeep: #subclasses 
		do: [:each | Transcript show: each]"

	| traverser action |
	action := DeepCustomActionStrategy new objectAction: anObjectActionBlock.
	traverser := DeepTraverser withCustomTraversal: aTraversalBlock.
	traverser 
		action: action;
		firstObjectAction: action;
		traverse: self
]

{ #category : #'*DeepTraverser' }
Object >> withDeep: aTraversalBlock do: anObjectActionBlock edgesDo: aRelationBlock [
	self withDeep: aTraversalBlock do: anObjectActionBlock relationDo: aRelationBlock

]

{ #category : #'*DeepTraverser' }
Object >> withDeep: aTraversalBlock do: anObjectActionBlock relationDo: aRelationBlock [
	"traverses all objects starting with and including the receiver using aTraversalBlock, and
	for each triggers anObjectActionBlock, and
	for each relation between two traversed objects triggers aRelationBlock.
	
	For example:
	Number 
		withDeep: #subclasses 
		do: [:each | Transcript show: each]
		relationDo: [ :from :to | Transcript show: from; show: ‘ <-- '; show: to; cr ]"

	| traverser action |
	action := DeepCustomActionStrategy new 
					objectAction: anObjectActionBlock;
					relationAction: aRelationBlock.
	traverser := DeepTraverser withCustomTraversal: aTraversalBlock.
	traverser 
		action: action;
		firstObjectAction: action;
		traverse: self
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
Object >> withDeepCollect: aTraversalBlock [
	"traverses all objects starting with and including the receiver using aTraversalBlock, and
	returns an OrderedCollection containing each traversed object.
	
	For example:
	Number withDeepCollect: #subclasses"

	| result |
	result := OrderedCollection new.
	self withDeep: aTraversalBlock do: [ :each | result add: each ].
	^ result
]
