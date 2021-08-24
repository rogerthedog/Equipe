Class {
	#name : #EPageQuestion,
	#superclass : #EPage,
	#instVars : [
		'messageText',
		'responseCollection'
	],
	#category : #Equipe
}

{ #category : #'instance creation' }
EPageQuestion class >> newMessage: messageText withResponses: responseCollection [

	| page |
	page := self new.
	page messageText: messageText.	
	page responseCollection: responseCollection.
	^ page
			
]

{ #category : #accessing }
EPageQuestion >> messageText [
	^ messageText
]

{ #category : #accessing }
EPageQuestion >> messageText: anObject [
	messageText := anObject
]

{ #category : #rendering }
EPageQuestion >> renderPageContentOn: html [ 

	html form: [
						
		html label: messageText.
	
		1 to: responseCollection size do: [ :index |  
			html submitButton callback: [ self answer: index ]; value: (responseCollection at: index).
		] 
	]
]

{ #category : #accessing }
EPageQuestion >> responseCollection [
	^ responseCollection
]

{ #category : #accessing }
EPageQuestion >> responseCollection: anObject [
	responseCollection := anObject
]
