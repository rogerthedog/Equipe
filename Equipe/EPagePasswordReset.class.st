Class {
	#name : #EPagePasswordReset,
	#superclass : #EPage,
	#instVars : [
		'emailAddress'
	],
	#category : #Equipe
}

{ #category : #accessing }
EPagePasswordReset >> emailAddress [
	^ emailAddress
]

{ #category : #accessing }
EPagePasswordReset >> emailAddress: anObject [
	emailAddress := anObject
]

{ #category : #accessing }
EPagePasswordReset >> needsSession [

	^ false

]

{ #category : #accessing }
EPagePasswordReset >> pageValidation [

	(emailAddress size between: 5 and: 320)	ifFalse: [
		self statusMessage: 'Please enter a valid email address' forKey: #emailAddress 		
	].

]

{ #category : #rendering }
EPagePasswordReset >> renderPageContentOn: html [ 

		html form: [
	
			html label for: 'ea'; with: 'Email Address '.
			self renderStatusMessageOn: html forKey: #emailAddress atControlId: 'ea'. 		
			html textInput id: 'ea'; callback: [ :value | self emailAddress: value ]; value: self emailAddress. 
			
			html submitButton callback: [ self sendResetMail ]; value: 'Reset my Password'.
			html anchor callback: [ self answer ]; with: 'Cancel reset'.

			self renderStatusMessageOn: html forKey: #page 		
	]
]

{ #category : #accessing }
EPagePasswordReset >> sendResetMail [ 

	| url mailTitle mailText|
	
	self resetErrorMessages.
	self pageValidation.
	
	self hasNoErrors ifTrue: [ 
		
		url := EStartTask createUrlPasswordResetForEmail: emailAddress fromSession: self session.	
	
		mailTitle := EConfiguration applicationName , ' Password Reset Request'.
		mailText := 'To reset your password please follow this link: ', url printString.
		
		EGmailer sendTextMailTo: emailAddress subject: mailTitle text: mailText.
		
		self showOkMessage: 'A Password Reset link has been sent to ', emailAddress.		
		
		self answer
	]
]
