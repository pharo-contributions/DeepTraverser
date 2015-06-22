Extension { #name : #UndefinedObject }

{ #category : #'*DeepTraverser' }
UndefinedObject >> pushForIterator: anIterator [
	" we never push nil as a processable item (traverse/action) "
]

{ #category : #'*DeepTraverser' }
UndefinedObject >> withIterator: anIterator action: anObject [
	" do nothing "
]

{ #category : #'*DeepTraverser' }
UndefinedObject >> withIterator: anIterator traverse: anObject [
	" do nothing "
]
