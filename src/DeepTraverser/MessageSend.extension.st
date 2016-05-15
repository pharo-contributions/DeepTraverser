Extension { #name : #MessageSend }

{ #category : #'*DeepTraverser' }
MessageSend >> withIterator: anIterator traverse: anObject [
	(self value: anObject) pushForIterator: anIterator
]

{ #category : #'*DeepTraverser' }
MessageSend >> withIteratorAction: anIterator from: from to: to [ 
	self cull: to cull: from
]
