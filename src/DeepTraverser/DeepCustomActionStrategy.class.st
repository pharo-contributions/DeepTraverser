"
This class models a custom action that can be parameterized through blocks:
- the objectAction is a block triggered for every traversed object
- the relationAction is a block that takes two arguments and it is triggered for each object relation
"
Class {
	#name : #DeepCustomActionStrategy,
	#superclass : #DeepActionStrategy,
	#instVars : [
		'objectAction',
		'relationAction'
	],
	#category : #DeepTraverser
}

{ #category : #hooks }
DeepCustomActionStrategy >> executeOnObject: anObject [
	^ self objectAction value: anObject
]

{ #category : #hooks }
DeepCustomActionStrategy >> executeOnRelationFrom: originObject to: targetObject [
	^ self relationAction value: originObject value: targetObject
]

{ #category : #initialization }
DeepCustomActionStrategy >> initialize [
	objectAction := [ :object | ].
	relationAction := [ :origin :target | ]
]

{ #category : #hooks }
DeepCustomActionStrategy >> objectAction [
	^ objectAction
]

{ #category : #hooks }
DeepCustomActionStrategy >> objectAction: aBlockWithOneArgument [
	objectAction := aBlockWithOneArgument
]

{ #category : #hooks }
DeepCustomActionStrategy >> relationAction [
	^ relationAction
]

{ #category : #hooks }
DeepCustomActionStrategy >> relationAction: aBlockWithTwoArguments [
	relationAction := aBlockWithTwoArguments
]
