Class {
	#name : #EPageDialog,
	#superclass : #EPage,
	#instVars : [
		'messageText',
		'responseCollection'
	],
	#category : #Equipe
}

{ #category : #rendering }
EPageDialog >> addAnchorResponse: aText [ 

	responseCollection add: 'A', aText
]

{ #category : #rendering }
EPageDialog >> addButtonResponse: aText [ 

	responseCollection add: 'B', aText
]

{ #category : #accessing }
EPageDialog >> initialize [ 

	super initialize.
	responseCollection := OrderedCollection new
]

{ #category : #accessing }
EPageDialog >> messageText: anObject [
	messageText := anObject
]

{ #category : #rendering }
EPageDialog >> renderPageContentOn: html [ 

	| text |
	html form: [
						
		html label: messageText.
	
		1 to: responseCollection size do: [ :index |  

			text := responseCollection at: index.
 
			(text beginsWith: 'B') ifTrue: [  
				html submitButton callback: [ self answer: index ]; value: (text withoutPrefix: 'B').
			]
			ifFalse: [  
				html anchor callback: [ self answer: index ]; with: (text withoutPrefix: 'A').
			]
		] 
	]
]
