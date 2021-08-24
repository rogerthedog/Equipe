Class {
	#name : #EGmailer,
	#superclass : #BGmailer,
	#category : #Equipe
}

{ #category : #'as yet unclassified' }
EGmailer class >> gmailAddress [
	
	^ EConfiguration gmailAddress 
]

{ #category : #'as yet unclassified' }
EGmailer class >> gmailPassword [
	
	^ EConfiguration gmailPassword 
]
