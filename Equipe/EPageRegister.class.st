Class {
	#name : #EPageRegister,
	#superclass : #EPage,
	#instVars : [
		'firstName',
		'lastName',
		'emailAddress',
		'password',
		'passwordAgain'
	],
	#category : #Equipe
}

{ #category : #accessing }
EPageRegister >> duplicateEmailValidation [

	| people |

	people := EDbPerson selectByEmailAddress: emailAddress.
			
	people isEmpty ifFalse: [  
		self statusMessage: 'There is already a registered user for the specified email address' forKey: #emailAddress 
	]
]

{ #category : #accessing }
EPageRegister >> emailAddress [
	^ emailAddress
]

{ #category : #accessing }
EPageRegister >> emailAddress: anObject [
	emailAddress := anObject
]

{ #category : #accessing }
EPageRegister >> firstName [
	^ firstName
]

{ #category : #accessing }
EPageRegister >> firstName: anObject [
	firstName := anObject
]

{ #category : #accessing }
EPageRegister >> lastName [
	^ lastName
]

{ #category : #accessing }
EPageRegister >> lastName: anObject [
	lastName := anObject
]

{ #category : #accessing }
EPageRegister >> needsSession [

	^ false
]

{ #category : #accessing }
EPageRegister >> pageValidation [

	(firstName size between: 1 and: 320)	ifFalse: [
		self statusMessage: 'Please enter a first name, up to 320 characters' forKey: #firstName 		
	].

	(lastName size between: 1 and: 320)	ifFalse: [
		self statusMessage: 'Please enter a last name, up to 320 characters' forKey: #lastName 		
	].

	(emailAddress size between: 5 and: 320)	ifFalse: [
		self statusMessage: 'Please enter a valid email address' forKey: #emailAddress 		
	].

	(password size between: 3 and: 40) ifFalse: [
		self statusMessage: 'Please enter a password between 3 and 40 characters' forKey: #password 		
	].

	(password = passwordAgain) ifFalse: [
		self statusMessage: 'Passwords must match' forKey: #password 		
	].


]

{ #category : #accessing }
EPageRegister >> password [
	^ password
]

{ #category : #accessing }
EPageRegister >> password: anObject [
	password := anObject
]

{ #category : #accessing }
EPageRegister >> passwordAgain [
	^ passwordAgain
]

{ #category : #accessing }
EPageRegister >> passwordAgain: anObject [
	passwordAgain := anObject
]

{ #category : #accessing }
EPageRegister >> registerAsCoach: isCoach [

	| person |
	self resetErrorMessages.
	self pageValidation.
	
	self hasNoErrors ifTrue: [ 
		self duplicateEmailValidation
	].	
	
	self hasNoErrors ifTrue: [ 

		person := EDbPerson new.
		person firstName: firstName. 
		person lastName: lastName. 
		person emailAddress: emailAddress. 
		person password: password. 
		isCoach ifTrue: [
			person startCoaching 
		] 
		ifFalse: [  
			person stopCoaching 
		].
		person insert.
		
		self session logInWith: person.
		self show: EPageStart new
	]
]

{ #category : #accessing }
EPageRegister >> registerAthlete [

	self registerAsCoach: false

]

{ #category : #accessing }
EPageRegister >> registerCoach [

	self registerAsCoach: true

]

{ #category : #rendering }
EPageRegister >> renderPageContentOn: html [ 

		html form: [
						
			html label for: 'fn'; with: 'First Name '.
			self renderStatusMessageOn: html forKey: #firstName atControlId: 'fn'. 		
			html textInput id: 'fn'; callback: [ :value | self firstName: value ]; value: self firstName. 
						
			html label for: 'ln'; with: 'Last Name '.
			self renderStatusMessageOn: html forKey: #lastName atControlId: 'ln'. 		
			html textInput id: 'ln'; callback: [ :value | self lastName: value ]; value: self lastName. 
						
			html label for: 'ea'; with: 'Email Address '.
			self renderStatusMessageOn: html forKey: #emailAddress atControlId: 'ea'. 		
			html textInput id: 'ea'; callback: [ :value | self emailAddress: value ]; value: self emailAddress. 
			
			html label for: 'pw'; with: 'Password '.
			self renderStatusMessageOn: html forKey: #password atControlId: 'pw'. 		
			html passwordInput id: 'pw'; callback: [ :value | self password: value ]; value: self password.

			html label for: 'pwa'; with: 'Retype Password '.
			html passwordInput id: 'pwa'; callback: [ :value | self passwordAgain: value ]; value: self passwordAgain.

			html label for: 'co'; with: 'If you want to work with athletes '.
			html submitButton id: 'co'; callback: [ self registerCoach ]; value: 'Register as a Coach'.
			
			html break.
			html label for: 'at'; with: 'If you are an athlete  '.
			html submitButton id: 'at'; callback: [ self registerAthlete ]; value: 'Register as an Athlete'.

			html break.
			html label: 'Which ever option you choose you will be able to change later'.

			html break.
			self renderStatusMessageOn: html forKey: #page 		
	]
]
