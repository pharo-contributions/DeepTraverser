Extension { #name : #Symbol }

{ #category : #'*DeepTraverser' }
Symbol >> withIterator: anIterator traverse: anObject [
	(anObject perform: self) pushForIterator: anIterator
]

{ #category : #'*DeepTraverser' }
Symbol >> withIteratorAction: anIterator from: from to: to [ 
	to perform: self withEnoughArguments: { from }
]
