Class {
	#name : #EStartTask,
	#superclass : #WATask,
	#instVars : [
		'onetime'
	],
	#category : #Equipe
}

{ #category : #hooks }
EStartTask class >> canBeRoot [
	^ true
]

{ #category : #hooks }
EStartTask class >> createUrlPasswordResetForEmail: anEmailAddress fromSession: aSession [

	| people onetime url newAction newKeyId |

	people := EDbPerson selectByEmailAddress: anEmailAddress.
	people size == 1 ifTrue: [  
		
		newAction := 'PasswordReset'.
		newKeyId := (people at: 1) rowid.

		onetime := EDbOnetime new.
		onetime action: newAction.
		onetime keyId: newKeyId. 	
		onetime insert.	

		[  
			EDbOnetime removeExpired
		] fork.

		url := WAUrl new initializeFromString: EConfiguration baseUrl. 
		url addField: 'action' value: newAction.
		url addField: 'keyId' value: newKeyId.
		url addField: 'onetimeCode' value: onetime onetimeCode.

	]. 

	^ url

]

{ #category : #hooks }
EStartTask class >> initialize [ 

	| app |
	
	app := WAAdmin register: self asApplicationAt: 'equipe'.
	app sessionClass: ESession   
]

{ #category : #hooks }
EStartTask >> go [

	| page |
	
	onetime ifNotNil: [  
		page := EPageAnonymousPassword new.
		page onetime: onetime.
		^ self show: page
	].

	self show: EPageStart new 
]

{ #category : #hooks }
EStartTask >> initialRequest: aRequest [ 

	| action fields |
	super initialRequest: aRequest. 
	
	fields := aRequest uri queryFields.  

	(fields includesKey: 'action') ifTrue: [  
		action := fields at: 'action'.
		
		action = 'PasswordReset' ifTrue: [  

			onetime := EDbOnetime new.
			onetime action: action.	
			onetime keyId: (fields at: 'keyId').	
			onetime onetimeCode: (fields at: 'onetimeCode').				
		]
	]

]
