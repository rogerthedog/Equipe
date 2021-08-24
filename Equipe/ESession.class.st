Class {
	#name : #ESession,
	#superclass : #WASession,
	#instVars : [
		'person'
	],
	#category : #Equipe
}

{ #category : #testing }
ESession >> ifLoggedInDo: aBlock [

	self isLoggedIn ifTrue: [  
		aBlock value: person 
	]

]

{ #category : #testing }
ESession >> ifLoggedInDo: loggedInBlock ifNotLoggedInDo: otherBlock [

	self isLoggedIn ifTrue: [  
		loggedInBlock value: person 
	] 	ifFalse: [
		otherBlock value		
	]

]

{ #category : #testing }
ESession >> isLoggedIn [
	
	^ person isNotNil
]

{ #category : #testing }
ESession >> logInWith: aPerson [
	
	person := aPerson 
]

{ #category : #testing }
ESession >> logOut [
	
	person := nil
]

{ #category : #testing }
ESession >> loggedInPerson [
	
	^ person
]
