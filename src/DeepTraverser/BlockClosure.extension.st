Extension { #name : #BlockClosure }

{ #category : #'*DeepTraverser-private' }
BlockClosure >> action: anObject using: aStream [
	self value: anObject
]

{ #category : #'*DeepTraverser-private' }
BlockClosure >> from: fromObject to: toObject using: aStream [
	self value: fromObject value: toObject
]

{ #category : #'*DeepTraverser-private' }
BlockClosure >> traverse: anObject using: aStream [
	(self value: anObject) traverseUsing: aStream
]
