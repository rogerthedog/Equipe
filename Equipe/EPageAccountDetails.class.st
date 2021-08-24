Class {
	#name : #EPageAccountDetails,
	#superclass : #EPage,
	#instVars : [
		'firstName',
		'lastName',
		'emailAddress',
		'person'
	],
	#category : #Equipe
}

{ #category : #accessing }
EPageAccountDetails >> duplicateEmailValidation [

	| people |

	people := EDbPerson selectByEmailAddress: emailAddress.
			
	people isEmpty ifFalse: [  
		self statusMessage: 'There is already a registered user for the specified email address' forKey: #emailAddress 
	]
]

{ #category : #accessing }
EPageAccountDetails >> emailAddress [
	^ emailAddress
]

{ #category : #accessing }
EPageAccountDetails >> emailAddress: anObject [
	emailAddress := anObject
]

{ #category : #accessing }
EPageAccountDetails >> firstName [
	^ firstName
]

{ #category : #accessing }
EPageAccountDetails >> firstName: anObject [
	firstName := anObject
]

{ #category : #accessing }
EPageAccountDetails >> lastName [
	^ lastName
]

{ #category : #accessing }
EPageAccountDetails >> lastName: anObject [
	lastName := anObject
]

{ #category : #accessing }
EPageAccountDetails >> pageValidation [

	(firstName size between: 1 and: 320)	ifFalse: [
		self statusMessage: 'Please enter a first name, up to 320 characters' forKey: #firstName 		
	].

	(lastName size between: 1 and: 320)	ifFalse: [
		self statusMessage: 'Please enter a last name, up to 320 characters' forKey: #lastName 		
	].

	(emailAddress size between: 5 and: 320)	ifFalse: [
		self statusMessage: 'Please enter a valid email address' forKey: #emailAddress 		
	]


]

{ #category : #accessing }
EPageAccountDetails >> person: aPerson [

	person := aPerson.
	firstName := aPerson firstName.
	lastName := aPerson lastName.
	emailAddress := aPerson emailAddress.
	 
]

{ #category : #rendering }
EPageAccountDetails >> renderPageContentOn: html [ 

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
			
		html submitButton id: 'up'; callback: [ self updateDetails ]; value: 'Update Details'.
		html anchor id: 'cn'; callback: [ self answer ]; with: 'Cancel Update'.

		html break.
		self renderStatusMessageOn: html forKey: #page 		
	]
]

{ #category : #accessing }
EPageAccountDetails >> updateDetails [

	self resetErrorMessages.
	self pageValidation.
	
	self hasNoErrors ifTrue: [ 
		person emailAddress = emailAddress ifFalse: [  
			self duplicateEmailValidation
		]
	].	
	
	self hasNoErrors ifTrue: [ 
		person firstName: firstName. 
		person lastName: lastName. 
		person emailAddress: emailAddress. 
		person update.
		self showOkMessage: 'Your details have been updated'.
		self answer
	]
]
