Extension { #name : #MessageSend }

{ #category : #'*DeepTraverser' }
MessageSend >> withIterator: anIterator perform: anObject [
	self value: anObject
]

{ #category : #'*DeepTraverser' }
MessageSend >> withIterator: anIterator traverse: anObject [
	(self value: anObject) pushForIterator: anIterator
]
