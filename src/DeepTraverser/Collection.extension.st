Extension { #name : #Collection }

{ #category : #'*DeepTraverser' }
Collection >> deep: aBlock1 do: aBlock2 [
	(DeepTraverser new 
		withAllStart: self;
		traverser: aBlock1;
		action: aBlock2;
		yourself) run
]

{ #category : #'*DeepTraverser-private' }
Collection >> pushForIterator: anIterator [
	self do: [ :each | 
		each pushForIterator: anIterator ]
]

{ #category : #'*DeepTraverser' }
Collection >> withDeep: aBlock1 do: aBlock2 [
	(DeepTraverser new 
		withAllStart: self;
		traverser: aBlock1;
		action: aBlock2;
		yourself) run
]
