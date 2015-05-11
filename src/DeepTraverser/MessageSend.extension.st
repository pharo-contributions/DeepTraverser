Extension { #name : #MessageSend }

{ #category : #'*DeepTraverser' }
MessageSend >> withIterator: anIterator action: anObject [
	self value: anObject
]

{ #category : #'*DeepTraverser' }
MessageSend >> withIterator: anIterator traverse: anObject [
	(self value: anObject) pushForIterator: anIterator
]
