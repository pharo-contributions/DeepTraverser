Class {
	#name : #DeepTraverserExamples,
	#superclass : #Object,
	#category : #'DeepTraverser-Examples'
}

{ #category : #'examples-difference' }
DeepTraverserExamples >> allMethodsArray [
	<gtExample>
	| resultByRaw resultByTraverser |
	
	resultByRaw := Array allSubclasses 
			flatCollect: [ :each | each methods ].
			
	resultByTraverser := Array
			deep: #subclasses 
			flatCollect: [ :each | each methods ].
	
	self assert: resultByRaw size = resultByTraverser size.
	self assert: resultByRaw asSet = resultByTraverser asSet.
	
]

{ #category : #'examples-difference' }
DeepTraverserExamples >> allMethodsObject [
	<gtExample>
	| resultByRaw resultByTraverser |
	
	resultByRaw := Object allSubclasses 
			flatCollect: [ :each | each methods ].
			
	resultByTraverser := Object
			deep: #subclasses 
			flatCollect: [ :each | each methods ].
	
	self assert: resultByRaw size = resultByTraverser size.
	self assert: resultByRaw asSet = resultByTraverser asSet.
	
]

{ #category : #'examples-difference' }
DeepTraverserExamples >> allSuperclassesNumber [
	<gtExample>
	| resultByRaw resultByTraverser |
	resultByRaw := Number allSuperclasses.
	resultByTraverser := Number deepCollect: #superclass.
	
	self assert: resultByRaw size = resultByTraverser size.
	self assert: resultByRaw asSet = resultByTraverser asSet.
	
]

{ #category : #'examples-difference' }
DeepTraverserExamples >> allSuperclassesObject [
	<gtExample>
	| resultByRaw resultByTraverser |
	resultByRaw := Object allSuperclasses.
	resultByTraverser := Object deepCollect: #superclass.
	
	self assert: resultByRaw size = resultByTraverser size.
	self assert: resultByRaw asSet = resultByTraverser asSet.
	
]

{ #category : #'examples-start-object' }
DeepTraverserExamples >> collectionAsStartOnObject [
	<gtExample>
	| result1 result2 |
	
	result1 := { Object }
		deep: #subclasses 
		flatCollect: [ :each | each methods ].
		
	result2 := Object
		deep: #subclasses 
		flatCollect: [ :each | each methods ].
	
	self assert: result1 = result2.
]

{ #category : #'examples-start-object' }
DeepTraverserExamples >> collectionAsWithStartOnObject [
	<gtExample>
	| result1 result2 |
	
	result1 := { Object }
		withDeep: #subclasses 
		flatCollect: [ :each | each methods ].
		
	result2 := Object
		withDeep: #subclasses 
		flatCollect: [ :each | each methods ].
	
	self assert: result1 = result2.
]

{ #category : #'examples-relations' }
DeepTraverserExamples >> collectionRelations: graph [
	<gtExample>
	<depends: #graph1>
	| relations |
	relations := OrderedCollection new.
	
	(DeepTraverser new 
		onNodeTraverse: [ :each | self nextElementsFor: each inGraph: graph ];
		onEdgeAction: [ :from :to | relations add: from->to ];
		on: graph startWith: 0; 
		yourself) run.
		
	self assert: relations size = 4.
	self assert: relations = { 0->1 . 1->2 . 1->3 . 2->3 } asOrderedCollection.
	
	^ relations
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> deepCollect: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		collect: [ :each | each * 10 ].
	self assert: result = #( 20 30 ) asOrderedCollection
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> deepCollectAs: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		collect: [ :each | each * 10 ]
		as: Set.
	self assert: result = #( 20 30 ) asSet
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> deepCollectAsSet: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		deepCollectAsSet: [ :each | self nextElementsFor: each inGraph: graph ].
	self assert: result = #( 2 3 ) asSet
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> deepCollectSimple: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		deepCollect: [ :each | self nextElementsFor: each inGraph: graph ].
	self assert: result = #( 2 3 ) asOrderedCollection
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> deepDo: graph [
	<gtExample>
	<depends: #graph1>
	
	| trace |
	trace := OrderedCollection new.
	1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		do: [ :each | trace add: each ].
	self assert: trace = #( 2 3 ) asOrderedCollection
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> deepDoRelationDo: graph [
	<gtExample>
	<depends: #graph1>
	
	| trace relationTrace |
	trace := OrderedCollection new.
	relationTrace := OrderedCollection new.
	1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		do: [ :each | trace add: each ]
		relationDo: [ :from :to | relationTrace add: from->to ].
	self assert: trace = #( 2 3 ) asOrderedCollection.
	self assert: relationTrace = { 1->2 . 1->3 . 2->3 } asOrderedCollection

]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> deepEdgesDo: graph [
	<gtExample>
	<depends: #graph1>
	
	| trace |
	trace := OrderedCollection new.
	1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		edgesDo: [ :from :to | trace add: (from -> to) ].
	self assert: trace = { 1->2. 1->3. 2->3 } asOrderedCollection
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> deepFlatCollect: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		flatCollect: [ :each | 1 to: each ].
	self assert: result = #( 1 2 1 2 3 ) asOrderedCollection
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> deepFlatCollectAs: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		flatCollect: [ :each | 1 to: each ]
		as: Set.
	self assert: result = #( 1 2 3 ) asSet
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> deepRelationDo: graph [
	<todo: 'is this really what we want ?'>
	<gtExample>
	<depends: #graph1>
	
	| relationTrace |
	relationTrace := OrderedCollection new.
	1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		relationDo: [ :from :to | relationTrace add: from->to ].
	self assert: relationTrace = { 1->2 . 1->3 . 2->3 } asOrderedCollection

]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> deepSelect: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		select: [ :each | each < 3 ].
	self assert: result = #( 2 ) asOrderedCollection
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> deepSelectCollectAs: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		deep: [ :each | self nextElementsFor: each inGraph: graph ]
		select: [ :each | each odd ]
		collect: [ :each | each ]
		as: Set.
	self assert: result = #( 3 ) asSet
]

{ #category : #utils }
DeepTraverserExamples >> deepTraverserOnGraph1: graph [
	<gtExample>
	<depends: #graph1>
	<subjectClass: #DeepTraverser>
	^ DeepTraverser new 
		onNodeTraverse: [ :each | self nextElementsFor: each inGraph: graph ];
		on: graph startWith: 0;
		yourself
]

{ #category : #utils }
DeepTraverserExamples >> deepTraverserWithoutActionOnGraph1: graph [
	<gtExample>
	<depends: #graph1>
	<subjectClass: #DeepTraverserWithoutAction>

	^ DeepTraverserWithoutAction new 
		onNodeTraverse: [ :each | self nextElementsFor: each inGraph: graph ];
		on: graph startWith: 0;
		yourself
]

{ #category : #utils }
DeepTraverserExamples >> deepTraverserWithoutEdgesOnGraph1: graph [
	<gtExample>
	<depends: #graph1>
	<subjectClass: #DeepTraverserWithoutEdges>
	
	^ DeepTraverserWithoutEdges new 
		onNodeTraverse: [ :each | self nextElementsFor: each inGraph: graph ];
		on: graph startWith: 0;
		yourself
]

{ #category : #'examples-specs' }
DeepTraverserExamples >> extensionVSFullDeclaration: graph [
	<gtExample>
	<depends: #graph1>
	| result1 result2 result3 result4 |
	
	" traverser shortcuts "
	result1 := $a
		withDeep: [ :item | self nextElementsFor: item inGraph: graph ]
		collect: [ :item | item ].
	
	" traverser specs "
	result2 := OrderedCollection new.
	(DeepTraverser new 
		onNodeTraverse: [ :item | self nextElementsFor: item inGraph: graph ];
		onNodeAction: [ :item | result2 add: item ];
		on: graph startWith: $a;
		yourself) run.
	self assert: result1 = result2.
	
	" collection interface "
	result3 := OrderedCollection new.
	(DeepTraverser new 
		onNodeTraverse: [ :item | self nextElementsFor: item inGraph: graph ];
		on: graph startWith: $a;
		yourself) do: [ :item | result3 add: item ].	
	self assert: result1 = result3.
	
	" streaming interface "
	result4 := (DeepTraverser new 
		onNodeTraverse: [ :item | self nextElementsFor: item inGraph: graph ];
		on: graph startWith: $a;
		yourself) upToEnd.	
	self assert: result1 = result4.
]

{ #category : #utils }
DeepTraverserExamples >> graph1 [
	<gtExample>
	| graph |
	graph := Dictionary new.
	graph at: 0 put: { 1 }.
	graph at: 1 put: { 2 . 3 }.
	graph at: 2 put: { 3 }.
	graph at: 4 put: { 3 }.
	graph at: 10 put: { 11 }.
	^ graph
]

{ #category : #utils }
DeepTraverserExamples >> graph2 [
	<gtExample>
	| graph |
	graph := Dictionary new.
	graph at: 0 put: { 4. 1 }.
	graph at: 1 put: { 4. 2 }.
	graph at: 2 put: { 4. 3 }.
	graph at: 3 put: { 4. }.
	graph at: 4 put: { 4. 5 }.
	^ graph
]

{ #category : #utils }
DeepTraverserExamples >> graph3 [
	<gtExample>
	| graph |
	graph := Dictionary new.
	graph at: 0 put: { 4. 1 }.
	graph at: 1 put: { 2 }.
	graph at: 2 put: { 3 }.
	graph at: 3 put: { 4. }.
	graph at: 4 put: { 5 }.
	^ graph
]

{ #category : #utils }
DeepTraverserExamples >> graph4 [
	<gtExample>
	| graph |
	graph := Dictionary new.
	graph at: 0 put: #( 1 2 3 4 ).
	graph at: 1 put: #( 5 6 ).
	graph at: 2 put: #( 7 8 ).
	graph at: 3 put: #( 9 10 ).
	graph at: 4 put: #( 10 ).
	graph at: 5 put: #( 6 ).
	graph at: 6 put: #( 5 7 ).
	graph at: 7 put: #( 8 9 ).
	graph at: 8 put: #( 8 9 ).
	graph at: 9 put: #( 10 ).
	graph at: 10 put: #( 9 ).
	^ graph
]

{ #category : #utils }
DeepTraverserExamples >> graph5 [
	<gtExample>
	^ Dictionary new
		at: $a put: #( $b $c $d );
		at: $b put: #( $e $f );
		at: $c put: #( $g $f );
		at: $g put: #( $f );
		at: $d put: #( $h $i );
		at: $f put: #( $j $k );
		at: $k put: #( $b $c );
		yourself
]

{ #category : #utils }
DeepTraverserExamples >> graph6 [
	<gtExample>
	^ Dictionary new
		at: 0 put: #( 3 4 );
		at: 1 put: #( 5 );
		at: 2 put: #( 6 );
		at: 3 put: #( 4 7 8 );
		at: 4 put: #( 9 1 0 );
		at: 5 put: #( 4 9 10 11 6 2 );
		at: 6 put: #( 12 13 );
		at: 7 put: #( );
		at: 8 put: #( 8 9 7 );
		at: 9 put: #( 9 );
		at: 10 put: #( 9 5 0 1 2 );
		at: 11 put: #( 6 );
		at: 12 put: #( );
		at: 13 put: #( );
		yourself
]

{ #category : #utils }
DeepTraverserExamples >> nextElementsFor: each inGraph: graph [
	^ graph at: each ifAbsent: [ #() ]
]

{ #category : #'examples-difference' }
DeepTraverserExamples >> plainTraverser: t1 withActionWithoutEdges: t2 withActionWithEdges: t3 [
	<gtExample>
	<depends: #deepTraverserOnGraph1:>
	<depends: #deepTraverserWithoutActionOnGraph1:>
	<depends: #deepTraverserWithoutEdgesOnGraph1:>
	<subjectClass: #DeepTraverserWithoutAction selector: #upToEnd>

	| result1 result2 result3 |
	result1 := t1 upToEnd.
	result2 := t2 upToEnd.
	result3 :=  t3 upToEnd.
	
	self assert: result1 = result2.
	self assert: result2 = result3.
	self assert: result3 = result1.
	
	^ { t1 . t2 . t3 }
]

{ #category : #'examples-streaming' }
DeepTraverserExamples >> streamingAtEnd: traverser [
	<gtExample>
	<depends: #streamingNext:>
	<raises: #CollectionIsEmpty>
	
	self assert: traverser hasNext not.
	self assert: traverser current isNil not.
	self assert: traverser current = $k.
	self assert: traverser atEnd.
	
	traverser next " oups "
]

{ #category : #'examples-streaming' }
DeepTraverserExamples >> streamingNext: traverser [
	<gtExample>
	<depends: #streamingTraverser:>
	
	self assert: traverser hasNext.
	self assert: traverser current isNil.
	self assert: traverser position = 0.
	
	self assert: traverser next = $a.
	self assert: traverser current = $a.
	self assert: traverser previous isNil.
	self assert: traverser position = 1.
	
	self assert: traverser next = $b.	
	self assert: traverser current = $b.
	self assert: traverser previous = $a.
	self assert: traverser position = 2.
		
	self assert: traverser next = $c.
	self assert: traverser next = $d.
	self assert: traverser next = $e.
	self assert: traverser next = $f.
	self assert: traverser next = $g.
	self assert: traverser next = $h.
	self assert: traverser next = $i.
	self assert: traverser next = $j.
	self assert: traverser next = $k.
	
	self assert: traverser atEnd.
	
	^ traverser
]

{ #category : #'examples-streaming' }
DeepTraverserExamples >> streamingNextElements: traverser [
	<gtExample>
	<depends: #streamingTraverser:>
	
	self assert: traverser hasNext.
	self assert: traverser current isNil.
	self assert: traverser position = 0.
	self assert: traverser atEnd not.
	
	self assert: (traverser next: 1) = { $a }.
	self assert: traverser atEnd not.
	
	self assert: (traverser next: 3) = { $b. $c. $d }.
	self assert: traverser atEnd not.
	
	self assert: (traverser next: 4) = { $e. $f. $g. $h }.
	self assert: traverser atEnd not.
	
	self assert: (traverser next: 100) = { $i. $j. $k. }.
	self assert: traverser atEnd.
	
	self assert: (traverser next: 100) = {}.
	self assert: traverser atEnd.
	
	self assert: (traverser next: 100) = {}.
	self assert: traverser atEnd.
	
	^ traverser
]

{ #category : #'examples-streaming' }
DeepTraverserExamples >> streamingRestart: traverser [
	<gtExample>
	<depends: #streamingNext:>
	
	traverser reset.
	
	self assert: traverser hasNext.
	self assert: traverser current isNil.
	self assert: traverser position = 0.
	
	self assert: traverser atEnd not.
]

{ #category : #'examples-streaming' }
DeepTraverserExamples >> streamingTraverser: graph [
	<gtExample>
	<depends: #graph5>
	^ DeepTraverserWithoutAction new 
		on: graph startWith: $a;
		onNodeTraverse: [ :each | self nextElementsFor: each inGraph: graph ];
		yourself
]

{ #category : #'examples-streaming' }
DeepTraverserExamples >> streamingUpToAnyExistingElement: traverser [
	<gtExample>
	<depends: #streamingUpToExistingElement:>
	
	| result |

	result := traverser upToAny: { $k. $i }.
	self assert: result asArray = { $g. $h }.
	self assert: traverser atEnd not.
	
	result := traverser upToAny: { $z. $y. $k }.
	self assert: result asArray = { $j }.
	
	self assert: traverser current = $k.
	self assert: traverser atEnd.
	
	^ traverser
]

{ #category : #'examples-streaming' }
DeepTraverserExamples >> streamingUpToAnyMatching: traverser [
	<gtExample>
	<depends: #streamingTraverser:>
	
	| result |
	result := traverser upToAnyMatching: [ :node | node = $c ].
	self assert: result asArray = { $a. $b }.
	self assert: traverser current = $c.
	
	result := traverser upToAnyMatching: [ :node | node asInteger > 102 and: [ node asInteger < 105 ] ].
	self assert: result asArray = { $d. $e. $f. }.
	
	^ traverser
]

{ #category : #'examples-streaming' }
DeepTraverserExamples >> streamingUpToEnd: traverser [
	<gtExample>
	<depends: #streamingTraverser:>
	
	| result |
	result := traverser upToEnd.
	self assert: result asArray = { $a. $b. $c. $d. $e. $f. $g. $h. $i. $j. $k }.
	self assert: traverser atEnd.
	
	^ traverser
]

{ #category : #'examples-streaming' }
DeepTraverserExamples >> streamingUpToExistingElement: traverser [
	<gtExample>
	<depends: #streamingTraverser:>
	
	| result |
	self assert: (traverser next: 2) = { $a. $b }.
	
	result := traverser upTo: $f.
	self assert: result asArray = { $c. $d. $e }.
	self assert: traverser current = $f.
	
	^ traverser
]

{ #category : #'examples-streaming' }
DeepTraverserExamples >> streamingUpToNonExistingElement: traverser [
	<gtExample>
	<depends: #streamingUpToExistingElement:>
	
	| result |

	result := traverser upTo: $b.
	self assert: result asArray = { $g. $h. $i. $j. $k }.
	self assert: traverser atEnd.
	
	^ traverser
]

{ #category : #'examples-relations' }
DeepTraverserExamples >> subclassesOfNumber [
	<gtExample>
	| relations traverser |
	relations := OrderedCollection new.
	
	traverser := (DeepTraverser new
		onNodeTraverse: #subclasses;
		onEdgeAction: [ :from :to |
			self assert: to superclass == from.
			relations add: (from -> to) ];
		on: Number startWith: Number;
		yourself) run.
	
	self assert: relations size = Number allSubclasses size.	
		
	^ relations
]

{ #category : #'examples-relations' }
DeepTraverserExamples >> superclassOfSmallInteger [
	<gtExample>
	| relations traverser |
	relations := OrderedCollection new.
	
	traverser := (DeepTraverser new
		onNodeTraverse: #superclass;
		onEdgeAction: [ :from :to |
			self assert: to == from superclass.
			relations add: (from -> to) ];
		on: Number startWith: SmallInteger;
		yourself) run.
	
	self assert: relations size = SmallInteger allSuperclasses size.	
		
	^ relations
]

{ #category : #'examples-relations' }
DeepTraverserExamples >> testCyclesAndEdgesInGraph2: graph [
	<gtExample>
	<depends: #graph2>
	| nodes edges traverser |

	nodes := OrderedCollection new.
	edges := OrderedCollection new.
	
	traverser := DeepTraverser new 
		onNodeAction: [ :node | nodes add: node ];
		onEdgeAction: [ :from :to | edges add: (from -> to) ];
		onNodeTraverse: [ :each | self nextElementsFor: each inGraph: graph ];
		on: graph startWith: 0;
		run.
	
	self assert: nodes = { 0. 4. 1. 5. 2. 3 } asOrderedCollection.
	self assert: edges = { 0->4. 4->4. 0->1. 1->4. 4->5. 1->2. 2->4. 2->3. 3->4. } asOrderedCollection.
	
	^ traverser
]

{ #category : #'examples-relations' }
DeepTraverserExamples >> testCyclesAndEdgesInGraph3: graph [
	<gtExample>
	<depends: #graph3>
	| nodes edges traverser |

	nodes := OrderedCollection new.
	edges := OrderedCollection new.
	
	traverser := DeepTraverser new 
		onNodeAction: [ :node | nodes add: node ];
		onEdgeAction: [ :from :to | edges add: (from -> to) ];
		onNodeTraverse: [ :each | self nextElementsFor: each inGraph: graph ];
		on: graph startWith: 0;
		run.
	
	self assert: nodes = { 0. 4. 1. 5. 2. 3 } asOrderedCollection.
	self assert: edges = { 0->4. 0->1. 4->5. 1->2. 2->3. 3->4. } asOrderedCollection.
	
	^ traverser
]

{ #category : #'examples-relations' }
DeepTraverserExamples >> testTraversedNodesInGraph4WithStart: resultWithStart withoutStart: resultWithoutStart [
	<gtExample>
	<description: 'withStart / withoutStart only specifies whether to apply the action on the start node or not - has no influence on the traversal itself'>
	<depends: #testTraversedNodesWithStartInGraph4:>
	<depends: #testTraversedNodesWithoutStartInGraph4:>
	
	self assert: resultWithStart = resultWithoutStart
]

{ #category : #'examples-relations' }
DeepTraverserExamples >> testTraversedNodesInGraph4WithoutStartAction: resultWithStartAction withoutStart: resultWithoutStart [
	<gtExample>
	<description: 'withStart / withoutStart only specifies whether to apply the action on the start node or not - has no influence on the traversal itself'>
	<depends: #testTraversedNodesWithoutStartActionInGraph4:>
	<depends: #testTraversedNodesWithoutStartInGraph4:>
	
	self assert: resultWithStartAction = resultWithoutStart
]

{ #category : #'examples-relations' }
DeepTraverserExamples >> testTraversedNodesWithStartInGraph4: graph [
	<gtExample>
	<depends: #graph4>
	
	| traverser traversedNodes |
	traverser := DeepTraverserWithoutAction new 
		onNodeTraverse: [ :each | self nextElementsFor: each inGraph: graph ];
		on: graph startWith: 0;
		yourself.
		
	traversedNodes := traverser upToEnd.
	self assert: traversedNodes = #( 0 1 2 3 4 5 6 7 8 9 10 ) asOrderedCollection.
	
	^ traversedNodes
]

{ #category : #'examples-relations' }
DeepTraverserExamples >> testTraversedNodesWithStartInGraph6: graph [
	<gtExample>
	<depends: #graph6>
	
	| traverser traversedNodes nodesWithAction edgesWithAction |
	nodesWithAction := OrderedCollection new.
	edgesWithAction := OrderedCollection new.
	
	traverser := DeepTraverser new 
		onNodeTraverse: [ :each | self nextElementsFor: each inGraph: graph ];
		onNodeAction: [ :node | nodesWithAction add: node ];
		onEdgeAction: [ :from :to | edgesWithAction add: (from -> to) ];
		on: graph startWithAll: #( 0 1 2 );
		yourself.
	
	traversedNodes := traverser upToEnd.
	
	self assert: traversedNodes = nodesWithAction.
	self assert: traversedNodes = { 0. 1. 2. 3. 4. 5. 6. 7. 8. 9. 10. 11. 12. 13. } asOrderedCollection.
	
	self assert: edgesWithAction = { 0->3. 0->4. 3->4. 4->1. 4->0. 1->5. 5->4. 5->2. 2->6. 5->6. 3->7. 3->8. 8->8. 8->7. 4->9. 5->9. 8->9. 9->9. 5->10. 10->9. 10->5. 10->0. 10->1. 10->2. 5->11. 11->6. 6->12. 6->13 } asOrderedCollection.
	^ traverser
	
]

{ #category : #'examples-relations' }
DeepTraverserExamples >> testTraversedNodesWithoutAllInGraph4: graph [
	<gtExample>
	<description: 'no matter how many (starting) nodes are excluded from the action, the traversal remains the same'>
	<depends: #graph4>
	
	| traverser traversedNodes nodesWithAction |
	nodesWithAction := OrderedCollection new.
	traverser := DeepTraverserWithoutAction new 
		onNodeTraverse: [ :each | self nextElementsFor: each inGraph: graph ];
		on: graph startWithoutAll: #( 0 1 2 3 4 );
		yourself.
		
	traversedNodes := traverser upToEnd.
	self assert: traversedNodes = #( 0 1 2 3 4 5 6 7 8 9 10 ) asOrderedCollection.
	nodesWithAction = #( 5 6 7 8 9 10 ) asOrderedCollection.
	
	^ traversedNodes
]

{ #category : #'examples-relations' }
DeepTraverserExamples >> testTraversedNodesWithoutStartActionInGraph4: graph [
	<gtExample>
	<depends: #graph4>
	
	| nodesByAction traverser traversedNodes |
	
	nodesByAction := OrderedCollection new.
	traverser := DeepTraverserWithoutEdges new 
		onNodeTraverse: [ :each | self nextElementsFor: each inGraph: graph ];
		onNodeAction: [ :each | nodesByAction add: each ];
		on: graph startWithout: 0;
		yourself.
	traversedNodes := traverser upToEnd.
	
	self assert: traversedNodes = #( 0 1 2 3 4 5 6 7 8 9 10 ) asOrderedCollection.
	self assert: nodesByAction = #( 1 2 3 4 5 6 7 8 9 10 ) asOrderedCollection.
	
	^ traversedNodes 

]

{ #category : #'examples-relations' }
DeepTraverserExamples >> testTraversedNodesWithoutStartInGraph4: graph [
	<gtExample>
	<depends: #graph4>
	
	| traverser traversedNodes |
	traverser := DeepTraverserWithoutAction new 
		onNodeTraverse: [ :each | self nextElementsFor: each inGraph: graph ];
		on: graph startWithout: 0;
		yourself.
		
	traversedNodes := traverser upToEnd.
	self assert: traversedNodes = #( 0 1 2 3 4 5 6 7 8 9 10 ) asOrderedCollection.
	
	^ traversedNodes
]

{ #category : #'examples-start-object' }
DeepTraverserExamples >> variationsOfDeepCollect [
	<gtExample>
	| result1 result2 result3 |
	
	result1 := { Collection } deepCollect: #subclasses as: Set.	
	result2 := Collection deepCollect: #subclasses as: Set.
	result3 := Collection allSubclasses asSet.
	
	self assert: result1 = result2.
	self assert: result2 = result3.
	self assert: result3 = result1.
]

{ #category : #'examples-start-object' }
DeepTraverserExamples >> variationsOfDeepCollectOfMultipleClasses [
	<gtExample>
	| result1 result2 result3 result4 |
	
	result1 := { Collection . Exception } deepCollect: #subclasses as: Set.	
	result2 := (Collection deepCollect: #subclasses as: Set) , (Exception deepCollect: #subclasses as: Set).
	result3 := ({ Collection } deepCollect: #subclasses as: Set) , ({ Exception } deepCollect: #subclasses as: Set).
	result4 := (Collection allSubclasses , Exception allSubclasses) asSet.
	
	self assert: result1 = result2.
	self assert: result2 = result3.
	self assert: result3 = result4.
	self assert: result4 = result1.
]

{ #category : #'examples-start-object' }
DeepTraverserExamples >> variationsOfWithDeepCollect [
	<gtExample>
	| result1 result2 result3 |
	
	result1 := { Collection } withDeepCollect: #subclasses as: Set.	
	result2 := Collection withDeepCollect: #subclasses as: Set.
	result3 := Collection withAllSubclasses asSet.
	
	self assert: result1 = result2.
	self assert: result2 = result3.
	self assert: result3 = result1.
]

{ #category : #'examples-start-object' }
DeepTraverserExamples >> variationsOfWithDeepCollectOfMultipleClasses [
	<gtExample>
	| result1 result2 result3 result4 |
	
	result1 := { Collection . Exception } withDeepCollect: #subclasses as: Set.	
	result2 := (Collection withDeepCollect: #subclasses as: Set) , (Exception withDeepCollect: #subclasses as: Set).
	result3 := ({ Collection } withDeepCollect: #subclasses as: Set) , ({ Exception } withDeepCollect: #subclasses as: Set).
	result4 := (Collection withAllSubclasses , Exception withAllSubclasses) asSet.
	
	self assert: result1 = result2.
	self assert: result2 = result3.
	self assert: result3 = result4.
	self assert: result4 = result1.
]

{ #category : #'examples-difference' }
DeepTraverserExamples >> withAllSubclassesNumber [
	<gtExample>
	| resultByRaw resultByTraverser |
	resultByRaw := Number withAllSubclasses.
	resultByTraverser := Number withDeepCollect: #subclasses.
	
	self assert: resultByRaw size = resultByTraverser size.
	self assert: resultByRaw asSet = resultByTraverser asSet.
	
]

{ #category : #'examples-difference' }
DeepTraverserExamples >> withAllSubclassesObject [
	<gtExample>
	| resultByRaw resultByTraverser |
	resultByRaw := Object withAllSubclasses.
	resultByTraverser := Object withDeepCollect: #subclasses.
	
	self assert: resultByRaw size = resultByTraverser size.
	self assert: resultByRaw asSet = resultByTraverser asSet.
	
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> withDeepCollect: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		withDeepCollect: [ :each | self nextElementsFor: each inGraph: graph ].
	self assert: result = #( 1 2 3 ) asOrderedCollection
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> withDeepCollectAs: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		withDeepCollect: [ :each | self nextElementsFor: each inGraph: graph ]
		as: Set.
	self assert: result asSet = #( 1 2 3 ) asSet
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> withDeepDo: graph [
	<gtExample>
	<depends: #graph1>
	
	| trace |
	trace := OrderedCollection new.
	1 
		withDeep: [ :each | self nextElementsFor: each inGraph: graph ] 
		do: [ :each | trace add: each ].
	self assert: trace = #( 1 2 3 ) asOrderedCollection
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> withDeepDoRelationDo: graph [
	<gtExample>
	<depends: #graph1>
	
	| trace relationTrace |
	trace := OrderedCollection new.
	relationTrace := OrderedCollection new.

	1 
		withDeep: [ :each | self nextElementsFor: each inGraph: graph ] 
		do: [ :each | trace add: each ]
		relationDo: [ :from :to | relationTrace add: from->to ].
	self assert: trace = #( 1 2 3 ) asOrderedCollection.
	self assert: relationTrace = { 1->2 . 1->3 . 2->3 } asOrderedCollection
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> withDeepEdgesDo: graph [
	<gtExample>
	<depends: #graph1>
	
	| trace |
	trace := OrderedCollection new.
	0 
		withDeep: [ :each | self nextElementsFor: each inGraph: graph ] 
		edgesDo: [ :from :to | trace add: (from -> to) ].
	self assert: trace = { 0->1. 1->2. 1->3. 2->3 } asOrderedCollection
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> withDeepFlatCollect: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		withDeep: [ :each | self nextElementsFor: each inGraph: graph ]
		flatCollect: [ :each | each to: 4 ].
	self assert: result = #( 1 2 3 4 2 3 4 3 4 ) asOrderedCollection
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> withDeepFlatCollectAs: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		withDeep: [ :each | self nextElementsFor: each inGraph: graph ]
		flatCollect: [ :each | each to: 4 ]
		as: Set.
	self assert: result = #( 1 2 3 4 2 3 4 3 4 ) asSet
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> withDeepRelationDo: graph [
	<gtExample>
	<depends: #graph1>
	
	| relationTrace |
	relationTrace := OrderedCollection new.

	1 
		withDeep: [ :each | self nextElementsFor: each inGraph: graph ] 
		relationDo: [ :from :to | relationTrace add: from->to ].
	self assert: relationTrace = { 1->2 . 1->3 . 2->3 } asOrderedCollection.
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> withDeepSelectCollect: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		withDeep: [ :each | self nextElementsFor: each inGraph: graph ]
		select: [ :each | each odd ]
		collect: [ :each | each * 10 ].
	self assert: result = #( 10 30 ) asOrderedCollection
]

{ #category : #'examples-extensions' }
DeepTraverserExamples >> withDeepSelectCollectAs: graph [
	<gtExample>
	<depends: #graph1>
	
	| result |
	result := 1 
		withDeep: [ :each | self nextElementsFor: each inGraph: graph ]
		select: [ :each | each odd ]
		collect: [ :each | each ]
		as: Set.
	self assert: result = #( 1 3 ) asSet
]

{ #category : #'examples-specs' }
DeepTraverserExamples >> withVSwithout [
	<gtExample>
	| result1 result2 diff21 diff12 |
	
	result1 := { Object }
		deep: #subclasses 
		flatCollect: [ :each | each methods ].
		
	result2 := Object
		withDeep: #subclasses 
		flatCollect: [ :each | each methods ].
	
	self assert: result1 ~= result2.
	self assert: result1 asSet ~= result2 asSet.
	
	self assert: (diff21 := result2 asSet difference: result1 asSet) notEmpty.
	self assert: (diff12 := result1 asSet difference: result2 asSet) isEmpty.
	
	self assert: (diff21 allSatisfy: [ :cm | cm methodClass = Object ]).
	self assert: diff21 asSet = Object methods asSet
]
