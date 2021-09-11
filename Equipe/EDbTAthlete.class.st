Class {
	#name : #EDbTAthlete,
	#superclass : #BTable,
	#instVars : [
		'coachId',
		'athleteId'
	],
	#category : #Equipe
}

{ #category : #'as yet unclassified' }
EDbTAthlete class >> metaDataSetColumnAliases [
	
	self addMetaDataColumnAlias: 'coach_person_id' forMember: 'coachId'.	
	self addMetaDataColumnAlias: 'athlete_person_id' forMember: 'athleteId'	
	
]

{ #category : #'as yet unclassified' }
EDbTAthlete class >> table [ 
	^ 'athlete'
]

{ #category : #accessing }
EDbTAthlete >> athleteId [

	^ athleteId
]

{ #category : #accessing }
EDbTAthlete >> athleteId: anObject [

	athleteId := anObject
]

{ #category : #accessing }
EDbTAthlete >> coachId [
	^ coachId
]

{ #category : #accessing }
EDbTAthlete >> coahId: anObject [
	coachId := anObject
]
