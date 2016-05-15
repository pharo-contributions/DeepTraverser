Class {
	#name : #DeepTreeGraphTraverserTest,
	#superclass : #DeepTraverserTest,
	#category : #DeepTraverser
}

{ #category : #private }
DeepTreeGraphTraverserTest >> assert: aResult graph: aDictionary iterator: aClass start: start [
	| result iterator |
	self shouldnt: [ 
		result := OrderedCollection new.
		iterator := aClass new 
			withStart: start;
			traverser: [ :e | aDictionary at: e ifAbsent: [ #() ] ];
			action: [ :e | result add: e ];
			yourself.
		iterator run ] raise: Error.
	self assert: result asArray = aResult asArray
]

{ #category : #private }
DeepTreeGraphTraverserTest >> graph [
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

{ #category : #tests }
DeepTreeGraphTraverserTest >> testAllMethods [
	| raw stream |
	self shouldnt: [ 
		raw := Object allSubclasses 
			flatCollect: [ :each | each methods ] ] raise: Error.
	self shouldnt: [ 
		stream := Object
			deep: #subclasses 
			flatCollect: [ :each | each methods ] ] raise: Error.
	self assert: raw asSet = stream asSet.
	
	self shouldnt: [ 
		raw := Array allSubclasses 
			flatCollect: [ :each | each methods ] ] raise: Error.
	self shouldnt: [ 
		stream := Array
			deep: #subclasses 
			flatCollect: [ :each | each methods ] ] raise: Error.
	self assert: raw asSet = stream asSet
]

{ #category : #tests }
DeepTreeGraphTraverserTest >> testAllSubclasses [
	| raw stream |
	self shouldnt: [ raw := Object allSubclasses ] raise: Error.
	self shouldnt: [ stream := Object deepCollect: #subclasses ] raise: Error.
	self assert: raw asSet = stream asSet.
	
	self shouldnt: [ raw := Number allSubclasses ] raise: Error.
	self shouldnt: [ stream := Number deepCollect: #subclasses ] raise: Error.
	self assert: raw asSet = stream asSet
]

{ #category : #tests }
DeepTreeGraphTraverserTest >> testBreadthFirstGraphIterator [
	self assert: #( $a $b $c $d $e $f $g $h $i $j $k ) 
		graph: self graph 
		iterator: DeepTraverser
		start: $a.
	
	self assert: #( $a $b $c $d $e $f $g $h $i $j $k ) = ($a
		withDeep: [ :item | self graph at: item ifAbsent: [ #() ] ]
		collect: [ :item | item ]) asArray.
		
	self assert: #( $a $b $c $d $e $f $g $h $i $j $k ) 
		graph: self tree 
		iterator: DeepTraverser
		start: $a.
	
	self assert: #( $a $b $c $d $e $f $g $h $i $j $k ) = ($a
		withDeep: [ :item | self tree at: item ifAbsent: [ #() ] ]
		collect: [ :item | item ]) asArray.
	
]

{ #category : #tests }
DeepTreeGraphTraverserTest >> testCollectionStart [
	| stream1 stream2 |
	self shouldnt: [ 
		stream1 := { Object }
			deep: #subclasses 
			flatCollect: [ :each | each methods ]  ] raise: Error.
	self shouldnt: [ 
		stream2 := Object
			withDeep: #subclasses 
			flatCollect: [ :each | each methods ] ] raise: Error.
	self assert: stream1 asSet = stream2 asSet
]

{ #category : #tests }
DeepTreeGraphTraverserTest >> testStreaming [
	| iterator performed |
	iterator := DeepTraverser new 
		withStart: $a;
		traverser: [ :item | self graph at: item ifAbsent: [ #() ] ];
		action: [ :item | performed := item ];
		yourself.
 
	self assert: iterator next = $a.
	self assert: iterator next = $b.	
		
	self assert: (iterator next: 4) = { $c. $d. $e. $f }.
	self assert: (iterator next: 4) = { $g. $h. $i. $j }.
	
	self shouldnt: [ iterator upToEnd ] raise: Error.
	self shouldnt: [ iterator upToEnd ] raise: Error.
	
	self should: [ iterator next ] raise: Error.
]

{ #category : #tests }
DeepTreeGraphTraverserTest >> testStreamingNext [
	| iterator performed |
	iterator := DeepTraverser new 
		withStart: $a;
		traverser: [ :item | self graph at: item ifAbsent: [ #() ] ];
		action: [ :item | performed := item ];
		yourself.

	self assert: iterator next = $a.
	self assert: iterator next = $b.	
	self assert: iterator next = $c.
	self assert: iterator next = $d.
	self assert: iterator next = $e.
	self assert: iterator next = $f.
	self assert: iterator next = $g.
	self assert: iterator next = $h.
	self assert: iterator next = $i.
	self assert: iterator next = $j.
	self assert: iterator next = $k.
	
	self assert: performed = $k.
	self should: [ iterator next ] raise: Error
]

{ #category : #tests }
DeepTreeGraphTraverserTest >> testStreamingNextProcessed [
	| iterator performed |
	iterator := DeepTraverser new 
		withStart: $a;
		traverser: [ :item | self graph at: item ifAbsent: [ #() ] ];
		action: [ :item | performed := item ];
		yourself.

	#( $a $b $c $d $e $f $g $h $i $j $k ) do: [ :each |
		self assert: iterator next = each ]
]

{ #category : #tests }
DeepTreeGraphTraverserTest >> testSuperclass [
	| raw stream |
	self shouldnt: [ raw := Object allSuperclasses ] raise: Error.
	self shouldnt: [ stream := Object deepCollect: #superclass ] raise: Error.
	self assert: raw asSet = stream asSet.
	
	self shouldnt: [ raw := Number allSuperclasses ] raise: Error.
	self shouldnt: [ stream := Number deepCollect: #superclass ] raise: Error.
	self assert: raw asSet = stream asSet
]

{ #category : #tests }
DeepTreeGraphTraverserTest >> testWithAllMethods [
	| raw stream |
	self shouldnt: [ 
		raw := Object withAllSubclasses 
			flatCollect: [ :each | each methods ] ] raise: Error.
	self shouldnt: [ 
		stream := Object
			withDeep: #subclasses 
			flatCollect: [ :each | each methods ] ] raise: Error.
	self assert: raw asSet = stream asSet.
	
	self shouldnt: [ 
		raw := Array withAllSubclasses 
			flatCollect: [ :each | each methods ] ] raise: Error.
	self shouldnt: [ 
		stream := Array
			withDeep: #subclasses 
			flatCollect: [ :each | each methods ] ] raise: Error.
	self assert: raw asSet = stream asSet
]

{ #category : #tests }
DeepTreeGraphTraverserTest >> testWithAllSubclasses [
	| raw stream |
	self shouldnt: [ raw := Object withAllSubclasses ] raise: Error.
	self shouldnt: [ stream := Object withDeepCollect: #subclasses ] raise: Error.
	self assert: raw asSet = stream asSet.
	
	self shouldnt: [ raw := Number withAllSubclasses ] raise: Error.
	self shouldnt: [ stream := Number withDeepCollect: #subclasses ] raise: Error.
	self assert: raw asSet = stream asSet
]

{ #category : #private }
DeepTreeGraphTraverserTest >> tree [
	^ Dictionary new
		at: $a put: #( $b $c $d );
		at: $b put: #( $e $f );
		at: $c put: #( $g );
		at: $d put: #( $h $i );
		at: $f put: #( $j $k );
		yourself
]
