Class {
	#name : #EPageAthletes,
	#superclass : #EPage,
	#instVars : [
		'pagingTable'
	],
	#category : #Equipe
}

{ #category : #rendering }
EPageAthletes >> children [ 
	^ Array with: pagingTable 
]

{ #category : #rendering }
EPageAthletes >> initialize [ 
	
	super initialize.
	pagingTable := EPagingTable new
]

{ #category : #rendering }
EPageAthletes >> renderPageContentOn: html [

	html form: [  
		
		html paragraph: 'Athletes'.
	
		pagingTable personId: self session loggedInPerson rowid.
		html render: pagingTable 		
	]

]
