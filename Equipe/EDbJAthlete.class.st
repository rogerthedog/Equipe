Class {
	#name : #EDbJAthlete,
	#superclass : #BJoin,
	#instVars : [
		'personFirstName',
		'personLastName',
		'personEmailAddress'
	],
	#category : #Equipe
}

{ #category : #adding }
EDbJAthlete class >> bindingBlockFor: aPersonId search: aText [ 

	| qualifiedText|

	aText ifNotNil: [  

		qualifiedText := '%', aText asUppercase, '%'.  

		^  [ :bindings | 
			bindings add: aPersonId.
			bindings add: qualifiedText.
			bindings add: qualifiedText.
			bindings add: qualifiedText] 
	] 
	ifNil: [  
		^  [ :bindings | bindings add: aPersonId ] 
	]


]

{ #category : #adding }
EDbJAthlete class >> countFor: aPersonId search: aText [ 

	^ self countWhere: (self whereClauseFor: aPersonId search: aText)  
	whereBindingBlock: (self bindingBlockFor: aPersonId search: aText)  

]

{ #category : #adding }
EDbJAthlete class >> loadTablesJoinsAggregates [
	
	self addTableClass: EDbTAthlete withAlias: 'athlete'.
	
	self addInnerJoinTableClass: EDbTPerson withAlias: 'person' onClause: 'person.rowid = athlete.athlete_person_id'.
	
]

{ #category : #adding }
EDbJAthlete class >> selectFor: aPersonId search: aText pageNumber: pageNumber rowsPerPage: rowsPerPage [

	^ self selectWhere: (self whereClauseFor: aPersonId search: aText)  
	whereBindingBlock: (self bindingBlockFor: aPersonId search: aText)  
	orderBy: 'person.last_name ASC, person.first_name ASC, person.email_address ASC' 
	page: pageNumber 
	rowsPerPage: rowsPerPage 


]

{ #category : #adding }
EDbJAthlete class >> whereClauseFor: aPersonId search: aText [

	aText ifNotNil: [  

		^ 'athlete.coach_person_id = ? AND (upper(person.first_name) like ? OR upper(person.last_name) LIKE ? OR upper(person.email_address) LIKE ?)' 
	] 
	ifNil: [  
		^ 'athlete.coach_person_id = ?' 
	]


]

{ #category : #accessing }
EDbJAthlete >> personEmailAddress [

	^ personEmailAddress
]

{ #category : #accessing }
EDbJAthlete >> personEmailAddress: anObject [

	personEmailAddress := anObject
]

{ #category : #accessing }
EDbJAthlete >> personFirstName [

	^ personFirstName
]

{ #category : #accessing }
EDbJAthlete >> personFirstName: anObject [

	personFirstName := anObject
]

{ #category : #accessing }
EDbJAthlete >> personLastName [

	^ personLastName
]

{ #category : #accessing }
EDbJAthlete >> personLastName: anObject [

	personLastName := anObject
]
