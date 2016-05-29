"
This class models no action with a null pattern.
"
Class {
	#name : #DeepNullActionStrategy,
	#superclass : #DeepActionStrategy,
	#category : #DeepTraverser
}

{ #category : #hooks }
DeepNullActionStrategy >> executeOnObject: anInteger [ 
	"do nothing"
]

{ #category : #hooks }
DeepNullActionStrategy >> executeOnRelationFrom: originObject to: targetObject [
	"do nothing"
	
]
