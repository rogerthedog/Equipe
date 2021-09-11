Class {
	#name : #EPage,
	#superclass : #WAComponent,
	#instVars : [
		'errorMessages'
	],
	#category : #Equipe
}

{ #category : #rendering }
EPage >> hasErrors [
	^ errorMessages isNotEmpty

]

{ #category : #rendering }
EPage >> hasNoErrors [
	^ errorMessages isEmpty

]

{ #category : #rendering }
EPage >> initialize [
		
	super initialize.	
	self resetErrorMessages

]

{ #category : #rendering }
EPage >> logOut [

	| questionPage answer |

	questionPage := EPageDialog new.
	questionPage messageText: 'Are you sure you want to Log Out?'.
	questionPage addButtonResponse: 'Log Out'.
	questionPage addAnchorResponse: 'Don''t Log Out'.

	answer := self call: questionPage.

	answer == 1 ifTrue: [
		self session logOut.
		self show: EPageStart new
	]

]

{ #category : #rendering }
EPage >> needsSession [

	^ true

]

{ #category : #rendering }
EPage >> renderContentOn: html [ 

	self needsSession ifTrue: [
		self session isLoggedIn ifFalse: [  
			self show: EPageLogIn new		
		]
	].
		
	self renderPageHeadingOn: html.
		
	html div class: 'pageborder'; with: [  
		self renderPageContentOn: html
	]

]

{ #category : #rendering }
EPage >> renderNavigationLinkOn: html block: aBlock text: aText [

		html anchor callback: aBlock; with: aText.	

]

{ #category : #rendering }
EPage >> renderNavigationLinkOn: html toClass: aClass text: aText [

	(self isKindOf: aClass) ifTrue: [  
		html anchor class: 'active'; with: aText.	
	]
	ifFalse: [  
		html anchor callback: [self show: aClass new]; with: aText.	
	
	]

]

{ #category : #rendering }
EPage >> renderPageContentOn: html [

	^ self subclassResponsibility 
]

{ #category : #rendering }
EPage >> renderPageHeadingOn: html [

	html div class: 'topnav'; with: [  
		
		self renderNavigationLinkOn: html toClass: EPageStart text: EConfiguration applicationName.

		html div class: 'topnav-right'; with: [
			
			self session isLoggedIn ifTrue: [  
				self session loggedInPerson isCoach ifTrue: [  
					self renderNavigationLinkOn: html toClass: EPageAthletes text: 'Athletes'					
				].
				self renderNavigationLinkOn: html toClass: EPageAccount text: 'Account'.
				self renderNavigationLinkOn: html block: [self logOut] text: 'Log Out'.
			] 
			ifFalse: [  
				self renderNavigationLinkOn: html toClass: EPageRegister text: 'Register'.
				self renderNavigationLinkOn: html toClass: EPageLogIn text: 'Log In'.
			]
		]
	]
	
]

{ #category : #rendering }
EPage >> renderStatusMessageOn: html forKey: aKey [

	(errorMessages includesKey: aKey) ifTrue: [
		html label class: 'errormessage'; with: (errorMessages at: aKey)
	]		

]

{ #category : #rendering }
EPage >> renderStatusMessageOn: html forKey: aKey atControlId: anId [

	(errorMessages includesKey: aKey) ifTrue: [
		html label class: 'errormessage'; for: anId; with: (errorMessages at: aKey).
	]		

]

{ #category : #rendering }
EPage >> resetErrorMessages [

	errorMessages := Dictionary new		

]

{ #category : #rendering }
EPage >> showOkMessage: aText [
		
	| questionPage |

	questionPage := EPageDialog new.
	questionPage messageText: aText.
	questionPage addButtonResponse: 'OK'.
	^ self call: questionPage
]

{ #category : #rendering }
EPage >> statusMessage: aMessage forKey: aKey [

	errorMessages at: aKey put: aMessage

]

{ #category : #rendering }
EPage >> style [ 

	^ '

body, h1, h2, h3, h4, h5, h6 {
  font-family: Arial, Helvetica, Arial, sans-serif;
}	

a:link {
  color: #4CAF50;
  text-decoration: none;
}

a:visited {
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
}

a:active {
  text-decoration: underline;
}
	
input[type=text], input[type=password], select {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

input[type=submit] {
  background-color: #04AA6D;
  color: white;
  padding: 14px 20px;
  margin: 8px 8px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 17px;
}

input[type=submit]:hover {
  background-color: #45a049;
}

.pageborder {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}

/* Red color for errors */
.errormessage {
    color: Red;
}

/* Add a black background color to the top navigation */
.topnav {
    background-color: #333;
    overflow: hidden;
}

/* Style the links inside the navigation bar */
.topnav a {
  float: left;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
}

/* Change the color of links on hover */
.topnav a:hover {
  background-color: #ddd;
  color: black;
}

/* Add a color to the active/current link */
.topnav a.active {
  background-color: #04AA6D;
  color: white;
}

/* Format the app name link */
.topnav a.appname {
	background-color: #333;
	color: #f2f2f2;
}

/* Right-aligned section inside the top navigation */
.topnav-right {
  float: right;
}

#pagingTable {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#pagingTable td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}


#pagingTable tr:hover {background-color: #ddd;}

#pagingTable th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #04AA6D;
  color: white;
}


.pagingTable {
  display: inline-block;
}

.pagination a {
  color: black;
  float: left;
  padding: 8px 16px;
  text-decoration: none;
}

.pagination a.active {
  background-color: #4CAA6D;
  color: white;
}

.pagination a:hover:not(.active) {background-color: #ddd;}

'	
]
