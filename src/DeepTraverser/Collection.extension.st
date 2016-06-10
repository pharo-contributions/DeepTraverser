Extension { #name : #Collection }

{ #category : #'*DeepTraverser-private' }
Collection >> startUsing: aStream [
	^ self anyOne
]

{ #category : #'*DeepTraverser-private' }
Collection >> traverseUsing: aStream [
	self do: [ :each | aStream traverse: each ]
]
