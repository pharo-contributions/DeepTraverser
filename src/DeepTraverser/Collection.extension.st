Extension { #name : #Collection }

{ #category : #'*DeepTraverser' }
Collection >> deep: aBlock1 do: aBlock2 [
	(DeepTraverser new 
		withAllStart: self;
		traverser: aBlock1;
		nodeAction: aBlock2;
		yourself) run
]

{ #category : #'*DeepTraverser' }
Collection >> deep: aBlock1 do: aBlock2 edgesDo: aBlock3 [
	(DeepTraverser new 
		withAllStart: self;
		traverser: aBlock1;
		nodeAction: aBlock2;
		edgeAction: aBlock3;
		yourself) run
]

{ #category : #'*DeepTraverser' }
Collection >> deep: aTraversalBlock edgesDo: anObjectEdgeActionBlock [
	(DeepTraverser new 
		withAllStart: self;
		traverser: aTraversalBlock;
		edgeAction: anObjectEdgeActionBlock;
		yourself) run
]

{ #category : #'*DeepTraverser-private' }
Collection >> pushForIterator: anIterator [
	self do: [ :each | 
		each pushForIterator: anIterator ]
]

{ #category : #'*DeepTraverser' }
Collection >> withDeep: aBlock1 do: aBlock2 [
	(DeepTraverser new 
		withAllStart: self;
		traverser: aBlock1;
		nodeAction: aBlock2;
		yourself) run
]

{ #category : #'*DeepTraverser' }
Collection >> withDeep: aTraversalBlock edgesDo: anObjectEdgeActionBlock [
	(DeepTraverser new 
		withAllStart: self;
		traverser: aTraversalBlock;
		edgeAction: anObjectEdgeActionBlock;
		yourself) run
]
