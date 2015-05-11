Extension { #name : #BlockClosure }

{ #category : #'*DeepTraverser' }
BlockClosure >> withIterator: anIterator action: anObject [ 
	self value: anObject
]

{ #category : #'*DeepTraverser' }
BlockClosure >> withIterator: anIterator traverse: anObject [ 
	(self value: anObject) pushForIterator: anIterator
]
