Class {
	#name : #EDbTOnetime,
	#superclass : #BTable,
	#instVars : [
		'keyId',
		'onetimeCode',
		'action'
	],
	#category : #Equipe
}

{ #category : #'as yet unclassified' }
EDbTOnetime class >> generateOnetimeCode [
	^ DateAndTime now hash
]

{ #category : #'as yet unclassified' }
EDbTOnetime class >> metaDataSetColumnAliases [
	
	self addMetaDataColumnAlias: 'key_id' forMember: 'keyId'.	
	self addMetaDataColumnAlias: 'onetime_code' forMember: 'onetimeCode'.	

]

{ #category : #'as yet unclassified' }
EDbTOnetime class >> removeExpired [

	| onetimeExpirySeconds expiryDateAndTime |
	
	onetimeExpirySeconds := EConfiguration onetimeExpiryDays.
	expiryDateAndTime := DateAndTime fromSeconds: (DateAndTime now asSeconds - onetimeExpirySeconds).
	
	self deleteWhere: 'created < ?' bindingBlock: [ :bindings | bindings add: expiryDateAndTime].

]

{ #category : #'as yet unclassified' }
EDbTOnetime class >> selectByAction: action keyId: keyId onetimeCode: onetimeCode [

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
EDbTOnetime class >> table [ 
	^ 'onetime'
]

{ #category : #accessing }
EDbTOnetime >> action [
	^ action
]

{ #category : #accessing }
EDbTOnetime >> action: anObject [
	action := anObject
]

{ #category : #accessing }
EDbTOnetime >> initialize [
	onetimeCode := self class generateOnetimeCode
]

{ #category : #accessing }
EDbTOnetime >> keyId [
	^ keyId
]

{ #category : #accessing }
EDbTOnetime >> keyId: anObject [
	keyId := anObject
]

{ #category : #accessing }
EDbTOnetime >> onetimeCode [
	^ onetimeCode
]

{ #category : #accessing }
EDbTOnetime >> onetimeCode: anObject [
	onetimeCode := anObject
]
