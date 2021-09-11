Class {
	#name : #EDbTPerson,
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
EDbTPerson class >> metaDataSetColumnAliases [
	
	self addMetaDataColumnAlias: 'first_name' forMember: 'firstName'.	
	self addMetaDataColumnAlias: 'last_name' forMember: 'lastName'.	
	self addMetaDataColumnAlias: 'email_address' forMember: 'emailAddress'.
	self addMetaDataColumnAlias: 'coach_ind' forMember: 'coachInd'.
	
]

{ #category : #'as yet unclassified' }
EDbTPerson class >> selectByEmailAddress: emailAddress [

	^ self selectWhere: 'emailAddress = ?' 
		whereBindingBlock:
		 [ :bindings |
			bindings add: emailAddress. 
		] 
		orderBy: ''
]

{ #category : #'as yet unclassified' }
EDbTPerson class >> selectByEmailAddress: emailAddress password: password [

	^ self selectWhere: 'emailAddress = ? AND password = ?' 
		whereBindingBlock:
		 [ :bindings |
			bindings add: emailAddress. 
			bindings add: (BEncryption encrypt: password)
		] 
		orderBy: ''
]

{ #category : #'as yet unclassified' }
EDbTPerson class >> table [ 
	^ 'person'
]

{ #category : #accessing }
EDbTPerson >> coachInd [
	^ coachInd
]

{ #category : #accessing }
EDbTPerson >> coachInd: anObject [
	coachInd := anObject
]

{ #category : #accessing }
EDbTPerson >> emailAddress [
	^ emailAddress
]

{ #category : #accessing }
EDbTPerson >> emailAddress: anObject [
	emailAddress := anObject
]

{ #category : #accessing }
EDbTPerson >> firstName [
	^ firstName
]

{ #category : #accessing }
EDbTPerson >> firstName: anObject [
	firstName := anObject
]

{ #category : #accessing }
EDbTPerson >> isCoach [

	^ coachInd = 'Y'
]

{ #category : #accessing }
EDbTPerson >> lastName [
	^ lastName
]

{ #category : #accessing }
EDbTPerson >> lastName: anObject [
	lastName := anObject
]

{ #category : #accessing }
EDbTPerson >> password [
	^ password
]

{ #category : #accessing }
EDbTPerson >> password: anObject [

	password := BEncryption encrypt: anObject 
]

{ #category : #accessing }
EDbTPerson >> startCoaching [

	coachInd := 'Y'
]

{ #category : #accessing }
EDbTPerson >> stopCoaching [

	coachInd := 'N'
]
