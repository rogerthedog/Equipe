Class {
	#name : #EPageAccount,
	#superclass : #EPage,
	#category : #Equipe
}

{ #category : #rendering }
EPageAccount >> changeDetails [

	|accountDetails|

	accountDetails := EPageAccountDetails new. 	
	accountDetails person: self session loggedInPerson. 	
	self show: accountDetails 
]

{ #category : #rendering }
EPageAccount >> changePassword [

	|accountPassword|

	accountPassword := EPageAccountPassword new. 	
	accountPassword person: self session loggedInPerson. 	
	self show: accountPassword 
]

{ #category : #rendering }
EPageAccount >> renderPageContentOn: html [ 

	| person |

	person := self session loggedInPerson. 

	html form: [
						
		html label for: 'fn'; with: 'First Name '.
		html textInput id: 'fn'; value: person firstName; readonly: true. 
						
		html label for: 'ln'; with: 'Last Name '.
		html textInput id: 'ln'; value: person lastName; readonly: true. 
						
		html label for: 'ea'; with: 'Email Address '.
		html textInput id: 'ea'; value: person emailAddress; readonly: true. 
						
		html submitButton callback: [ self changeDetails ]; value: 'Change Details'.
		html horizontalRule. 
		html submitButton callback: [ self changePassword ]; value: 'Change Password'.

		html horizontalRule. 
		person isCoach ifTrue: [  
			html label for: 'co'; with: 'If you no longer want to work with athletes '.
			html submitButton id: 'co'; callback: [ self stopCoaching: person ]; value: 'Stop Coaching'.
		] ifFalse: [  
			html label for: 'co'; with: 'If you want to work with athletes '.
			html submitButton id: 'co'; callback: [ self startCoaching: person ]; value: 'Start Coaching'.
		]

	]


]

{ #category : #rendering }
EPageAccount >> startCoaching: aPerson [

	| question responses questionPage answer |

	responses := OrderedCollection new.
	responses add: 'Start coaching'.
	responses add: 'Don''t change'.
	question := 'Are you sure you want to coach athletes? This option will allow you to create and manage your team of athletes'.
	
	questionPage := EPageQuestion newMessage: question withResponses: responses.

	answer := self call: questionPage.

	answer == 1 ifTrue: [

		self updatePerson: aPerson asCoach: true

	]

]

{ #category : #rendering }
EPageAccount >> stopCoaching: aPerson [

	| question responses questionPage answer |

	responses := OrderedCollection new.
	responses add: 'Stop coaching'.
	responses add: 'Don''t change'.
	question := 'Are you sure you want to stop coaching athletes? You will no longer be able to manage your team of athletes'.
	
	questionPage := EPageQuestion newMessage: question withResponses: responses.

	answer := self call: questionPage.

	answer == 1 ifTrue: [

		self updatePerson: aPerson asCoach: false

	]

]

{ #category : #rendering }
EPageAccount >> updatePerson: aPerson asCoach: personWantsToCoach [

	personWantsToCoach ifTrue: [
		aPerson startCoaching 
	] 
	ifFalse: [  	
		aPerson stopCoaching 
	].
	aPerson update.

]
