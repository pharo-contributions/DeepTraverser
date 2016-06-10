Extension { #name : #Collection }

{ #category : #'*DeepTraverser-private' }
Collection >> dtStartUsing: aStream [
	^ self anyOne
]

{ #category : #'*DeepTraverser-private' }
Collection >> dtTraverseUsing: aStream [
	self do: [ :each | aStream traverse: each ]
]
