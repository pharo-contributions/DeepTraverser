Extension { #name : #Object }

{ #category : #'*DeepTraverser' }
Object >> deep: aTraversalBlock collect: aCollectBlock [
	^ self 
		deep: aTraversalBlock 
		collect: aCollectBlock 
		as: OrderedCollection
]

{ #category : #'*DeepTraverser' }
Object >> deep: aTraversalBlock collect: aCollectBlock as: aCollectionClass [
	| result |
	result := aCollectionClass new.
	self 
		deep: aTraversalBlock 
		do: [ :each | result add: (aCollectBlock value: each) ].
	^ result
]

{ #category : #'*DeepTraverser' }
Object >> deep: aTraversalBlock do: anObjectActionBlock [
	| traverser action |
	action := DeepCustomActionStrategy new objectAction: anObjectActionBlock.
	traverser := DeepTraverser withCustomTraversal: aTraversalBlock.
	traverser 
		action: action;
		traverse: self
]

{ #category : #'*DeepTraverser' }
Object >> deep: aTraversalBlock do: anObjectActionBlock relationDo: aRelationBlock [
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
	^ self 
		deep: aTraversalBlock 
		flatCollect: aCollectBlock 
		as: OrderedCollection
]

{ #category : #'*DeepTraverser' }
Object >> deep: aTraversalBlock flatCollect: aCollectBlock as: aCollectionClass [
	| result |
	result := aCollectionClass new.
	self 
		deep: aTraversalBlock 
		do: [ :each | result addAll: (aCollectBlock value: each) ].
	^ result
]

{ #category : #'*DeepTraverser' }
Object >> deepCollect: aBlock [
	^ self 
		deep: aBlock 
		collect: [ :each | each ]
]

{ #category : #'*DeepTraverser' }
Object >> deepCollectAsSet: aBlock [
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
	| traverser action |
	action := DeepCustomActionStrategy new objectAction: anObjectActionBlock.
	traverser := DeepTraverser withCustomTraversal: aTraversalBlock.
	traverser 
		action: action;
		firstObjectAction: action;
		traverse: self
]

{ #category : #'*DeepTraverser' }
Object >> withDeepCollect: aBlock [
	| result |
	result := OrderedCollection new.
	self withDeep: aBlock do: [ :each | result add: each ].
	^ result
]
