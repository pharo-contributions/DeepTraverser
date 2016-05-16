Extension { #name : #MessageSend }

{ #category : #'*DeepTraverser' }
MessageSend >> withIterator: anIterator traverse: anObject [
	(self value: anObject) pushForIterator: anIterator
]

{ #category : #'*DeepTraverser' }
MessageSend >> withIteratorEdgeAction: anIterator [
	anIterator performEdgeActionMessageSend: self
]

{ #category : #'*DeepTraverser' }
MessageSend >> withIteratorNodeAction: anIterator [
	anIterator performNodeActionMessageSend: self
]
