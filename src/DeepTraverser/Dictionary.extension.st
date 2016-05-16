Extension { #name : #Dictionary }

{ #category : #'*DeepTraverser' }
Dictionary >> deep: aBlock1 do: aBlock2 [
	(DeepTraverser new 
		withStart: self keys anyOne;
		traverser: aBlock1;
		nodeAction: aBlock2;
		yourself) run
]

{ #category : #'*DeepTraverser' }
Dictionary >> deep: aTraversalBlock edgesDo: anObjectEdgeActionBlock [
	(DeepTraverser new 
		withoutStart: self keys anyOne;
		traverser: aTraversalBlock;
		edgeAction: anObjectEdgeActionBlock;
		yourself) run
]

{ #category : #'*DeepTraverser' }
Dictionary >> withDeep: aBlock1 do: aBlock2 [
	(DeepTraverser new 
		withStart: self keys anyOne;
		traverser: aBlock1;
		nodeAction: aBlock2;
		yourself) run
]

{ #category : #'*DeepTraverser' }
Dictionary >> withDeep: aTraversalBlock edgesDo: anObjectEdgeActionBlock [
	(DeepTraverser new 
		withStart: self keys anyOne;
		traverser: aTraversalBlock;
		edgeAction: anObjectEdgeActionBlock;
		yourself) run
]
