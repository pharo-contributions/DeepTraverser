Extension { #name : #HashedCollection }

{ #category : #'*DeepTraverser-private' }
HashedCollection >> dtStartUsing: aStream [
	^ self keys anyOne
]
