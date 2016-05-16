Extension { #name : #BlockClosure }

{ #category : #'*DeepTraverser' }
BlockClosure >> withIterator: anIterator traverse: anObject [ 
	(self value: anObject) pushForIterator: anIterator
]

{ #category : #'*DeepTraverser' }
BlockClosure >> withIteratorEdgeAction: anIterator [
	anIterator performEdgeActionBlock: self
]

{ #category : #'*DeepTraverser' }
BlockClosure >> withIteratorNodeAction: anIterator [
	anIterator performNodeActionBlock: self
]
