Extension { #name : #HashedCollection }

{ #category : #'*DeepTraverser-private' }
HashedCollection >> startUsing: aStream [
	^ self keys anyOne
]
