Class {
	#name : #EDbOnetime,
	#superclass : #BTable,
	#instVars : [
		'keyId',
		'onetimeCode',
		'action'
	],
	#category : #Equipe
}

{ #category : #'as yet unclassified' }
EDbOnetime class >> generateOnetimeCode [
	^ DateAndTime now hash
]

{ #category : #'as yet unclassified' }
EDbOnetime class >> metaDataSetColumnAliases [
	
	self addMetaDataColumnAlias: 'key_id' forMember: 'keyId'.	
	self addMetaDataColumnAlias: 'onetime_code' forMember: 'onetimeCode'.	

]

{ #category : #'as yet unclassified' }
EDbOnetime class >> removeExpired [

	| onetimeExpirySeconds expiryDateAndTime |
	
	onetimeExpirySeconds := EConfiguration onetimeExpiryDays.
	expiryDateAndTime := DateAndTime fromSeconds: (DateAndTime now asSeconds - onetimeExpirySeconds).
	
	self deleteWhere: 'created < ?' bindingBlock: [ :bindings | bindings add: expiryDateAndTime].

]

{ #category : #'as yet unclassified' }
EDbOnetime class >> selectByAction: action keyId: keyId onetimeCode: onetimeCode [

	^ self selectWhere: 'action = ? AND keyId = ? AND onetimeCode = ?' 
		whereBindingBlock:
		 [ :bindings |
			bindings add: action. 
			bindings add: keyId. 
			bindings add: onetimeCode. 
		] 
		orderBy: ''
]

{ #category : #'as yet unclassified' }
EDbOnetime class >> table [ 
	^ 'onetime'
]

{ #category : #accessing }
EDbOnetime >> action [
	^ action
]

{ #category : #accessing }
EDbOnetime >> action: anObject [
	action := anObject
]

{ #category : #accessing }
EDbOnetime >> initialize [
	onetimeCode := self class generateOnetimeCode
]

{ #category : #accessing }
EDbOnetime >> keyId [
	^ keyId
]

{ #category : #accessing }
EDbOnetime >> keyId: anObject [
	keyId := anObject
]

{ #category : #accessing }
EDbOnetime >> onetimeCode [
	^ onetimeCode
]

{ #category : #accessing }
EDbOnetime >> onetimeCode: anObject [
	onetimeCode := anObject
]
