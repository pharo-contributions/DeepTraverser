Extension { #name : #BlockClosure }

{ #category : #'*DeepTraverser' }
BlockClosure >> withIterator: anIterator perform: anObject [ 
	self value: anObject
]

{ #category : #'*DeepTraverser' }
BlockClosure >> withIterator: anIterator traverse: anObject [ 
	(self value: anObject) pushForIterator: anIterator
]
