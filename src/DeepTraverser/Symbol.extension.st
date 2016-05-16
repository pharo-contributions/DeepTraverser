Extension { #name : #Symbol }

{ #category : #'*DeepTraverser' }
Symbol >> withIterator: anIterator traverse: anObject [
	(anObject perform: self) pushForIterator: anIterator
]

{ #category : #'*DeepTraverser' }
Symbol >> withIteratorEdgeAction: anIterator [
	anIterator performEdgeActionSymbol: self
]

{ #category : #'*DeepTraverser' }
Symbol >> withIteratorNodeAction: anIterator [
	anIterator performNodeActionSymbol: self
]
