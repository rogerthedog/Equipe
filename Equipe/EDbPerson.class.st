Class {
	#name : #EDbPerson,
	#superclass : #BTable,
	#instVars : [
		'firstName',
		'lastName',
		'emailAddress',
		'password',
		'coachInd'
	],
	#category : #Equipe
}

{ #category : #'as yet unclassified' }
EDbPerson class >> metaDataSetColumnAliases [
	
	self addMetaDataColumnAlias: 'first_name' forMember: 'firstName'.	
	self addMetaDataColumnAlias: 'last_name' forMember: 'lastName'.	
	self addMetaDataColumnAlias: 'email_address' forMember: 'emailAddress'.
	self addMetaDataColumnAlias: 'coach_ind' forMember: 'coachInd'.
	
]

{ #category : #'as yet unclassified' }
EDbPerson class >> selectByEmailAddress: emailAddress [

	^ self selectWhere: 'emailAddress = ?' 
		whereBindingBlock:
		 [ :bindings |
			bindings add: emailAddress. 
		] 
		orderBy: ''
]

{ #category : #'as yet unclassified' }
EDbPerson class >> selectByEmailAddress: emailAddress password: password [

	^ self selectWhere: 'emailAddress = ? AND password = ?' 
		whereBindingBlock:
		 [ :bindings |
			bindings add: emailAddress. 
			bindings add: (BEncryption encrypt: password)
		] 
		orderBy: ''
]

{ #category : #'as yet unclassified' }
EDbPerson class >> table [ 
	^ 'person'
]

{ #category : #accessing }
EDbPerson >> coachInd [
	^ coachInd
]

{ #category : #accessing }
EDbPerson >> coachInd: anObject [
	coachInd := anObject
]

{ #category : #accessing }
EDbPerson >> emailAddress [
	^ emailAddress
]

{ #category : #accessing }
EDbPerson >> emailAddress: anObject [
	emailAddress := anObject
]

{ #category : #accessing }
EDbPerson >> firstName [
	^ firstName
]

{ #category : #accessing }
EDbPerson >> firstName: anObject [
	firstName := anObject
]

{ #category : #accessing }
EDbPerson >> isCoach [

	^ coachInd = 'Y'
]

{ #category : #accessing }
EDbPerson >> lastName [
	^ lastName
]

{ #category : #accessing }
EDbPerson >> lastName: anObject [
	lastName := anObject
]

{ #category : #accessing }
EDbPerson >> password [
	^ password
]

{ #category : #accessing }
EDbPerson >> password: anObject [

	password := BEncryption encrypt: anObject 
]

{ #category : #accessing }
EDbPerson >> startCoaching [

	coachInd := 'Y'
]

{ #category : #accessing }
EDbPerson >> stopCoaching [

	coachInd := 'N'
]
