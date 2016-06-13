Extension { #name : #SequenceableCollection }

{ #category : #'*DeepTraverser' }
SequenceableCollection >> deep: aTraversalBlock do: anObjectActionBlock [
	(DeepTraverser new 
		onNodeTraverse: aTraversalBlock;
		onNodeAction: anObjectActionBlock;
		withoutAll: self;
		yourself) run
]

{ #category : #'*DeepTraverser' }
SequenceableCollection >> deep: aTraversalBlock do: anObjectActionBlock relationDo: aRelationBlock [
	" wie cannot traverse this graph without all items of self - so we include them "
	(DeepTraverser new 
		onNodeTraverse: aTraversalBlock;
		onNodeAction: anObjectActionBlock;
		onEdgeAction: aRelationBlock;
		withoutAll: self;
		yourself) run
]

{ #category : #'*DeepTraverser' }
SequenceableCollection >> deep: aTraversalBlock relationDo: anObjectEdgeActionBlock [
	" wie cannot traverse this graph without all items of self - so we include them "
	(DeepTraverser new 
		onNodeTraverse: aTraversalBlock;
		onEdgeAction: anObjectEdgeActionBlock;
		withoutAll: self;
		yourself) run
]

{ #category : #'*DeepTraverser' }
SequenceableCollection >> withDeep: aTraversalBlock do: anObjectActionBlock [
	" wie cannot traverse this graph without all items of self - so we include them "
	(DeepTraverser new 
		onNodeTraverse: aTraversalBlock;
		onNodeAction: anObjectActionBlock;
		withAll: self;
		yourself) run
]

{ #category : #'*DeepTraverser' }
SequenceableCollection >> withDeep: aTraversalBlock do: anObjectActionBlock relationDo: aRelationBlock [
	(DeepTraverser new 
		onNodeTraverse: aTraversalBlock;
		onNodeAction: anObjectActionBlock;
		onEdgeAction: aRelationBlock;
		withAll: self;
		yourself) run
]

{ #category : #'*DeepTraverser' }
SequenceableCollection >> withDeep: aTraversalBlock relationDo: anObjectEdgeActionBlock [

	(DeepTraverser new 
		onNodeTraverse: aTraversalBlock;
		onEdgeAction: anObjectEdgeActionBlock;
		withAll: self;
		yourself) run
]
