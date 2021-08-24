Class {
	#name : #EPageAnonymousPassword,
	#superclass : #EPage,
	#instVars : [
		'newPassword',
		'retypeNewPassword',
		'onetime',
		'person'
	],
	#category : #Equipe
}

{ #category : #accessing }
EPageAnonymousPassword >> newPassword [
	^ newPassword
]

{ #category : #accessing }
EPageAnonymousPassword >> newPassword: anObject [
	newPassword := anObject
]

{ #category : #accessing }
EPageAnonymousPassword >> onetime [
	^ onetime
]

{ #category : #accessing }
EPageAnonymousPassword >> onetime: anObject [
	
	|codes|
	
	onetime := anObject.
	
	"Look for the matching onetime"
	codes := EDbOnetime selectByAction: (anObject action) keyId: (anObject keyId) onetimeCode: (anObject onetimeCode).
	
	codes size == 1 ifTrue: [  
		person := EDbPerson selectById: (codes at: 1) keyId.
		(codes at: 1) delete
	
	]


]

{ #category : #accessing }
EPageAnonymousPassword >> pageValidation [

	(newPassword size between: 3 and: 40) ifFalse: [
		self statusMessage: 'Please enter a password between 3 and 40 characters' forKey: #newPassword 		
	].

	(newPassword = retypeNewPassword) ifFalse: [
		self statusMessage: 'Passwords must match' forKey: #retypeNewPassword 		
	].

]

{ #category : #rendering }
EPageAnonymousPassword >> renderPageContentOn: html [ 

	html form: [

		person ifNotNil: [  

			html label for: 'np'; with: 'New Password '.
			self renderStatusMessageOn: html forKey: #newPassword atControlId: 'np'. 		
			html passwordInput id: 'np'; callback: [ :value | self newPassword: value ]; value: self newPassword. 
						
			html label for: 'rn'; with: 'Retype New Password '.
			self renderStatusMessageOn: html forKey: #retypeNewPassword atControlId: 'rn'. 		
			html passwordInput id: 'rn'; callback: [ :value | self retypeNewPassword: value ]; value: self retypeNewPassword. 
			
			html submitButton id: 'up'; callback: [ self updatePassword ]; value: 'Update Password'.

			html break.
			self renderStatusMessageOn: html forKey: #page 

		] 
		ifNil: [  

			self statusMessage: 'Your request to change password has expired' forKey: #page.
			self renderStatusMessageOn: html forKey: #page. 
			html break.
			html submitButton callback: [ self show: EPagePasswordReset new ]; value: 'Password Reset'.
		]
	]


]

{ #category : #accessing }
EPageAnonymousPassword >> retypeNewPassword [
	^ retypeNewPassword
]

{ #category : #accessing }
EPageAnonymousPassword >> retypeNewPassword: anObject [
	retypeNewPassword := anObject
]

{ #category : #accessing }
EPageAnonymousPassword >> updatePassword [

	self resetErrorMessages.
	self pageValidation.
	
	self hasNoErrors ifTrue: [ 
		person password: newPassword.  
		person update.
		self showOkMessage: 'Your password has been updated'.
		self show: EPageStart new
	]
]
