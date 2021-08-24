Class {
	#name : #EDbConnection,
	#superclass : #BConnection,
	#category : #Equipe
}

{ #category : #'instance creation' }
EDbConnection class >> databaseFileName [

	^ EConfiguration databaseFileName  
]
