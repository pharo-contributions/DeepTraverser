"
This class models an action that is triggered both on each traversed object, and on each relation between two objects. The action is triggered exactly once per object/relation occurrence.
"
Class {
	#name : #DeepActionStrategy,
	#superclass : #Object,
	#category : #DeepTraverser
}

{ #category : #hooks }
DeepActionStrategy >> executeOnObject: anObject [
	"override this method in subclasses to trigger
	behavior associated with each traversed object"

	self subclassResponsibility 
]

{ #category : #hooks }
DeepActionStrategy >> executeOnRelationFrom: originObject to: targetObject [
	"override this method in subclasses to trigger
	behavior associated with the relation between 
	the origin and the target of a traversed relation"
	
	self subclassResponsibility
]
