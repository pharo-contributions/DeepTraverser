Extension { #name : #Symbol }

{ #category : #'*DeepTraverser-private' }
Symbol >> action: anObject using: aStream [
	anObject perform: self
]

{ #category : #'*DeepTraverser-private' }
Symbol >> from: fromObject to: toObject using: aStream [
	fromObject perform: self with: toObject
]

{ #category : #'*DeepTraverser-private' }
Symbol >> traverse: anObject using: aStream [
	(anObject perform: self) dtTraverseUsing: aStream
]
