Class {
	#name : #EConfiguration,
	#superclass : #BConfiguration,
	#category : #Equipe
}

{ #category : #initialize }
EConfiguration class >> applicationName [ 
	
	^ self valueForKey: 'applicationName'
]

{ #category : #initialize }
EConfiguration class >> baseUrl [ 
	
	^ self valueForKey: 'baseUrl'
]

{ #category : #initialize }
EConfiguration class >> databaseFileName [ 
	
	^ self valueForKey: 'databaseFileName'
]

{ #category : #initialize }
EConfiguration class >> delimiter [

	^ '|'
]

{ #category : #initialize }
EConfiguration class >> fileReference [

	^ Smalltalk imageDirectory / 'equipe.cfg'
]

{ #category : #initialize }
EConfiguration class >> gmailAddress [ 
	
	^ self valueForKey: 'gmailAddress'
]

{ #category : #initialize }
EConfiguration class >> gmailPassword [ 
	
	^ self valueForKey: 'gmailPassword'
]

{ #category : #initialize }
EConfiguration class >> onetimeExpiryDays [ 
	
	^ self valueForKey: #onetimeExpiryDays
]
