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
	anIterator pushAllForIteration: self
]

{ #category : #'*DeepTraverser' }
Collection >> withDeep: aBlock1 do: aBlock2 [
	(DeepTraverser new 
		withAllStart: self;
		traverser: aBlock1;
		action: aBlock2;
		yourself) run
]
