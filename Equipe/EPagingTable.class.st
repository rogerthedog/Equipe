Class {
	#name : #EPagingTable,
	#superclass : #WAComponent,
	#instVars : [
		'searchText',
		'results',
		'currentPage',
		'rowsPerPage',
		'personId'
	],
	#category : #Equipe
}

{ #category : #rendering }
EPagingTable >> initialize [ 

	super initialize.
	currentPage := 1. 
	rowsPerPage := 10 
]

{ #category : #rendering }
EPagingTable >> personId: aPersonId [
	personId := aPersonId.
	self search
]

{ #category : #rendering }
EPagingTable >> renderContentOn: html [

	html form: [  

		html label for: 'seachText'; with: 'Search For '.
		html textInput id: 'searchText'; callback: [ :value | searchText := value ]; value: searchText. 
		html submitButton id: 'search'; callback: [ self search ]; value: 'Search'.

		self renderTableContentOn: html.
		
		html div class: 'pagination'; with: [  
		
			html anchor callback: [  ]; with: '<<'.		
			html anchor callback: [  ]; with: '<'.		
			html anchor callback: [  ]; with: '6'.		
			html anchor class: 'active'; callback: [  ]; with: '7'.		
			html anchor callback: [  ]; with: '8'.		
			html anchor callback: [  ]; with: '9'.		
			html anchor callback: [  ]; with: '10'.		
			html anchor callback: [  ]; with: '>'.		
		].
	
		html break
		
		].	

	



]

{ #category : #rendering }
EPagingTable >> renderTableContentOn: html [

	html table id: 'pagingTable'; with: [  
		
		html tableRow: [  
			html tableHeading: 'First Name'.
			html tableHeading: 'Last Name'.
			html tableHeading: 'Email Address'
		].
		
		results ifEmpty: [  
			html tableRow: [  
				html tableData colSpan: 3; with: 'No Results to Show'
			]
		]. 

		results do: [ :athlete |  
			html tableRow: [  
				html tableData: athlete personFirstName.
				html tableData: athlete personLastName.
				html tableData: athlete personEmailAddress.
			]
		]
		
	]	


	



]

{ #category : #rendering }
EPagingTable >> search [

	results := EDbJAthlete for: personId search: searchText pageNumber: currentPage rowsPerPage: rowsPerPage  
]
