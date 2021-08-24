Class {
	#name : #EPageAccountPassword,
	#superclass : #EPage,
	#instVars : [
		'password',
		'newPassword',
		'retypeNewPassword',
		'person'
	],
	#category : #Equipe
}

{ #category : #accessing }
EPageAccountPassword >> existingPasswordValidation [

	| people |

	people := EDbPerson selectByEmailAddress: person emailAddress password: self password.
			
	people isEmpty ifTrue: [  
		self statusMessage: 'This is not the correct password for this user account' forKey: #password 
	]
]

{ #category : #accessing }
EPageAccountPassword >> newPassword [
	^ newPassword
]

{ #category : #accessing }
EPageAccountPassword >> newPassword: anObject [
	newPassword := anObject
]

{ #category : #accessing }
EPageAccountPassword >> pageValidation [

	(password size between: 3 and: 40) ifFalse: [
		self statusMessage: 'Please enter a password between 3 and 40 characters' forKey: #password 		
	].

	(newPassword size between: 3 and: 40) ifFalse: [
		self statusMessage: 'Please enter a password between 3 and 40 characters' forKey: #newPassword 		
	].

	(newPassword = retypeNewPassword) ifFalse: [
		self statusMessage: 'Passwords must match' forKey: #retypeNewPassword 		
	].

]

{ #category : #accessing }
EPageAccountPassword >> password [
	^ password
]

{ #category : #accessing }
EPageAccountPassword >> password: anObject [
	password := anObject
]

{ #category : #accessing }
EPageAccountPassword >> person [
	^ person
]

{ #category : #accessing }
EPageAccountPassword >> person: aPerson [

	person := aPerson.

]

{ #category : #rendering }
EPageAccountPassword >> renderPageContentOn: html [ 

	html form: [
						
		html label for: 'pw'; with: 'Password '.
		self renderStatusMessageOn: html forKey: #password atControlId: 'pw'. 		
		html passwordInput id: 'pw'; callback: [ :value | self password: value ]; value: self password. 
						
		html label for: 'np'; with: 'New Password '.
		self renderStatusMessageOn: html forKey: #newPassword atControlId: 'np'. 		
		html passwordInput id: 'np'; callback: [ :value | self newPassword: value ]; value: self newPassword. 
						
		html label for: 'rn'; with: 'Retype New Password '.
		self renderStatusMessageOn: html forKey: #retypeNewPassword atControlId: 'rn'. 		
		html passwordInput id: 'rn'; callback: [ :value | self retypeNewPassword: value ]; value: self retypeNewPassword. 
			
		html submitButton id: 'up'; callback: [ self updatePassword ]; value: 'Update Password'.
		html anchor id: 'cn'; callback: [ self answer ]; with: 'Cancel Update'.

		html break.
		self renderStatusMessageOn: html forKey: #page 		
	]
]

{ #category : #accessing }
EPageAccountPassword >> retypeNewPassword [
	^ retypeNewPassword
]

{ #category : #accessing }
EPageAccountPassword >> retypeNewPassword: anObject [
	retypeNewPassword := anObject
]

{ #category : #accessing }
EPageAccountPassword >> updatePassword [

	self resetErrorMessages.
	self pageValidation.
	
	self hasNoErrors ifTrue: [ 
		self existingPasswordValidation
	].

	self hasNoErrors ifTrue: [ 
		person password: newPassword.  
		person update.
		self showOkMessage: 'Your password has been updated'.
		self answer
	]
]
