Extension { #name : #BlockClosure }

{ #category : #'*DeepTraverser' }
BlockClosure >> withIterator: anIterator traverse: anObject [ 
	(self value: anObject) pushForIterator: anIterator
]

{ #category : #'*DeepTraverser' }
BlockClosure >> withIteratorAction: anIterator from: from to: to [ 
	self cull: to cull: from
]
