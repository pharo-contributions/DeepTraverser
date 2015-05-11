Class {
	#name : #DeepTraverser,
	#superclass : #Object,
	#instVars : [
		'current',
		'currentProcessed',
		'first',
		'objectsProcessed',
		'objectsToProcess',
		'performer',
		'start',
		'traverser'
	],
	#category : #DeepTraverser
}

{ #category : #testing }
DeepTraverser >> atEnd [
	^ self hasNext not
]

{ #category : #private }
DeepTraverser >> basicProcess [
	self objectsProcessed add: current.
	self doTraverse.
	^ self doPerform.
]

{ #category : #'accessing-defaults' }
DeepTraverser >> defaultCollectionClass [
	^ OrderedCollection
]

{ #category : #'accessing-defaults' }
DeepTraverser >> defaultOrdered [
	^ true
]

{ #category : #'public-enumerating' }
DeepTraverser >> do: aBlock [
	[ self atEnd ] whileFalse: [ 
		aBlock value: self next ]
]

{ #category : #private }
DeepTraverser >> doPerform [
	start == current ifTrue: [ start == first ifFalse: [ ^ nil ] ].
	self performer withIterator: self perform: current.
	^ current
]

{ #category : #'public-enumerating' }
DeepTraverser >> doProcessed: aBlock [
	[ self atEnd ] whileFalse: [ 
		self next.
		self isCurrentProcessed ifTrue: [ 
			aBlock value: currentProcessed ] ]
]

{ #category : #private }
DeepTraverser >> doTraverse [
	self traverser withIterator: self traverse: current
]

{ #category : #accessing }
DeepTraverser >> first [
	^ first
]

{ #category : #testing }
DeepTraverser >> hasNext [
	^ self objectsToProcess notEmpty
]

{ #category : #testing }
DeepTraverser >> isCurrentProcessed [
	^ current == currentProcessed
]

{ #category : #'public-streaming' }
DeepTraverser >> next [
	current := self pickCurrent.
	currentProcessed := self process.
	^ current
]

{ #category : #'public-streaming' }
DeepTraverser >> next: anInteger [
	| index newArray |
	index := 0.
	newArray := Array new: anInteger.
	[ index < anInteger and: [ self atEnd not ] ] whileTrue: [ 
		newArray at: (index := index + 1) put: self next ].
	^ newArray copyFrom: 1 to: index	
]

{ #category : #'public-streaming' }
DeepTraverser >> nextProcessed [
	| continueNext |
	continueNext := [ self atEnd not ].
	[ continueNext value ] whileTrue: [ 
		self next.
		continueNext := [ self isCurrentProcessed not and: [ self atEnd not ] ] ].
	^ currentProcessed
]

{ #category : #'public-streaming' }
DeepTraverser >> nextProcessed: anInteger [
	| index newArray |
	index := 0.
	newArray := Array new: anInteger.
	[ index < anInteger and: [ self atEnd not ] ] whileTrue: [ 
		newArray at: (index := index + 1) put: self nextProcessed ].
	^ newArray copyFrom: 1 to: index
]

{ #category : #private }
DeepTraverser >> objectsProcessed [
	^ objectsProcessed ifNil: [ objectsProcessed := IdentitySet new ]
]

{ #category : #private }
DeepTraverser >> objectsToProcess [
	^ objectsToProcess ifNil: [ objectsToProcess := OrderedCollection with: self start ]
]

{ #category : #accessing }
DeepTraverser >> performer [
	^ performer
]

{ #category : #accessing }
DeepTraverser >> performer: anObject [
	performer := anObject
]

{ #category : #private }
DeepTraverser >> pickCurrent [
	^ self objectsToProcess removeFirst
]

{ #category : #private }
DeepTraverser >> pickNext [
	^ self subclassResponsibility
]

{ #category : #'public-streaming' }
DeepTraverser >> position [
	^ self objectsProcessed size
]

{ #category : #private }
DeepTraverser >> process [
	(self objectsProcessed includes: current) ifTrue: [ ^ nil ].
	^ self basicProcess
]

{ #category : #private }
DeepTraverser >> pushAllForIteration: anObject [
	self objectsToProcess addAll: anObject
]

{ #category : #private }
DeepTraverser >> pushForIteration: anObject [
	self objectsToProcess add: anObject
]

{ #category : #'public-streaming' }
DeepTraverser >> reset [
	current := nil.
	currentProcessed := nil.
	objectsToProcess := nil.
	objectsProcessed := nil.	

]

{ #category : #'public-enumerating' }
DeepTraverser >> run [
	[ self atEnd ] whileFalse: [ 
		self next ]
]

{ #category : #accessing }
DeepTraverser >> start [
	^ start
]

{ #category : #'accessing-convenience' }
DeepTraverser >> traversedObjects [
	^ self objectsProcessed
]

{ #category : #accessing }
DeepTraverser >> traverser [
	^ traverser
]

{ #category : #accessing }
DeepTraverser >> traverser: anObject [
	traverser := anObject
]

{ #category : #'public-streaming' }
DeepTraverser >> upTo: anObject [
	| newArray |
	newArray := OrderedCollection new.
	[ self atEnd not and: [ (self next = anObject) not ] ] whileTrue: [ 
		 newArray add: current ].
	^ newArray
]

{ #category : #'public-streaming' }
DeepTraverser >> upToAny: aCollection [
	^ self upToAnyMatching: [ :each | aCollection includes: each ]
]

{ #category : #'public-streaming' }
DeepTraverser >> upToAnyMatching: aBlock [
	| newArray |
	newArray := OrderedCollection new.
	[ self atEnd not and: [ (aBlock value: self next) not ] ] whileTrue: [ 
		 newArray add: current ].
	^ newArray
]

{ #category : #'public-streaming' }
DeepTraverser >> upToAnyProcessed: aCollection [
	^ self upToAnyProcessedMatching: [ :each | aCollection includes: each ]
]

{ #category : #'public-streaming' }
DeepTraverser >> upToAnyProcessedMatching: aBlock [
	| newArray |
	newArray := OrderedCollection new.
	[ self atEnd not and: [ (aBlock value: self nextProcessed) not and: [ self isCurrentProcessed ] ] ] whileTrue: [ 
		 newArray add: currentProcessed ].
	^ newArray
]

{ #category : #'public-streaming' }
DeepTraverser >> upToEnd [
	| newArray |
	newArray := OrderedCollection new.
	[ self atEnd ] whileFalse: [ 
		newArray add: self next ].
	^ newArray
]

{ #category : #'public-streaming' }
DeepTraverser >> upToEndProcessed [
	| newArray |
	newArray := OrderedCollection new.
	[ self atEnd ] whileFalse: [ 
		self nextProcessed.
		self isCurrentProcessed ifTrue: [
			newArray add: currentProcessed ] ].
	^ newArray
]

{ #category : #'public-streaming' }
DeepTraverser >> upToProcessed: anObject [
	| newArray |
	newArray := OrderedCollection new.
	[ self atEnd not and: [ (self nextProcessed = anObject) not and: [ self isCurrentProcessed ] ] ] whileTrue: [ 
		 newArray add: currentProcessed ].
	^ newArray
]

{ #category : #'accessing-convenience' }
DeepTraverser >> withAllStart: aCollection [
	objectsToProcess := OrderedCollection withAll: aCollection. " aCollection must not be touched ! "
	aCollection ifNotEmpty: [ 
		self withStart: aCollection anyOne " compatibility: probably #first " ]
]

{ #category : #'accessing-convenience' }
DeepTraverser >> withStart: anObject [
	start := anObject.
	first := anObject
]

{ #category : #'accessing-convenience' }
DeepTraverser >> withoutStart: anObject [
	start := anObject.
	first := nil
]
