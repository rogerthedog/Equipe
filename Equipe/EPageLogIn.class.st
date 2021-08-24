Class {
	#name : #EPageLogIn,
	#superclass : #EPage,
	#instVars : [
		'emailAddress',
		'password'
	],
	#category : #Equipe
}

{ #category : #accessing }
EPageLogIn >> emailAddress [
	^ emailAddress
]

{ #category : #accessing }
EPageLogIn >> emailAddress: anObject [
	emailAddress := anObject
]

{ #category : #accessing }
EPageLogIn >> logIn [
	| people |
	self resetErrorMessages.
	self pageValidation.
	
	self hasNoErrors ifTrue: [ 
		people := EDbPerson selectByEmailAddress: emailAddress password: password.
			
		people size = 1 ifTrue: [  
			self session logInWith: (people at: 1).
			self show: EPageStart new
		]
		ifFalse: 	[ 
			self statusMessage: 'No details found for the specified credentials' forKey: #page 
		]
	]
]

{ #category : #accessing }
EPageLogIn >> needsSession [

	^ false

]

{ #category : #accessing }
EPageLogIn >> pageValidation [

	(emailAddress size between: 5 and: 320)	ifFalse: [
		self statusMessage: 'Please enter a valid email address' forKey: #emailAddress 		
	].

	(password size between: 3 and: 40)	ifFalse: [
		self statusMessage: 'Please enter a password between 3 and 40 characters' forKey: #password 		
	].


]

{ #category : #accessing }
EPageLogIn >> password [
	^ password
]

{ #category : #accessing }
EPageLogIn >> password: anObject [
	password := anObject
]

{ #category : #rendering }
EPageLogIn >> renderPageContentOn: html [ 

		html form: [
			
			
			html label for: 'ea'; with: 'Email Address '.
			self renderStatusMessageOn: html forKey: #emailAddress atControlId: 'ea'. 		
			html textInput id: 'ea'; callback: [ :value | self emailAddress: value ]; value: self emailAddress. 
			
			html label for: 'pw'; with: 'Password '.
			self renderStatusMessageOn: html forKey: #password atControlId: 'pw'. 		
			html passwordInput id: 'pw'; callback: [ :value | self password: value ]; value: self password.

			html submitButton callback: [ self logIn ]; value: 'Log in'.
			html anchor callback: [ self resetPassword ]; with: 'I forgot My Password'.

			self renderStatusMessageOn: html forKey: #page 		
	]
]

{ #category : #accessing }
EPageLogIn >> resetPassword [

	|passwordResetPage|
	
	passwordResetPage := EPagePasswordReset new.
	passwordResetPage emailAddress: self emailAddress.
	self show: passwordResetPage  
]
