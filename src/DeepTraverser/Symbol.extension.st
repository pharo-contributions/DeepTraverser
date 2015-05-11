Extension { #name : #Symbol }

{ #category : #'*DeepTraverser' }
Symbol >> withIterator: anIterator action: anObject [
	anObject perform: self
]

{ #category : #'*DeepTraverser' }
Symbol >> withIterator: anIterator traverse: anObject [
	(anObject perform: self) pushForIterator: anIterator
]
