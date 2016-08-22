Extension { #name : #DeepTraverserWithoutAction }

{ #category : #'*DeepTraverser-UI' }
DeepTraverserWithoutAction >> gtInspectorObjectsTraversedIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list
		title: 'Traversed';
		display: [ self objectsTraversed ];
		format: [ :each | each gtDisplayString ]
]
