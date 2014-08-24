pegStart = topLevel

topLevel = ws* ( grammarContent* / pattern ) ws*

pattern
	= ( "element" ws+ nameClass ws* "{" ws* pattern ws* "}" )
	/ ( "attribute" ws+ nameClass ws* "{" ws* pattern ws* "}" )
	/ ( pattern ( ws* "," ws* pattern ) + )
	/ ( pattern ( ws* "&" ws* pattern ) + )
	/ ( pattern ( ws* "/" ws* pattern ) + )
	/ identifier
	/ "empty"
	/ "text"

grammarContent
	= start
	/ define

start
	= "start" ws* assignMethod ws* pattern eol

define
	= identifier ws* assignMethod ws* pattern eol

assignMethod 
	= "="
	/ "|="
	/ "&="

nameClass
	= name

name
	= identifierOrKeyword
	/ CName

exceptNameClass
	= "-" nameClass

datatypeName 
	= CName
	/ "string"
	/ "token"

datatypeValue
	= literal

anyURILiteral
	= literal

namespaceURILiteral
	= literal
	/ "inherit"

inherit
	= "inherit" "=" identifierOrKeyword

identifierOrKeyword 
	= identifier
	/ keyword

identifier 
	= ( NCName ! keyword )
	/ quotedIdentifier

quotedIdentifier
	= "\"" NCName

CName
	= NCName ":" NCName

nsName
	= NCName ":*"

anyName
	= "*"

literal
	=

keyword
	= "attribute"
	/ "default"
	/ "datatypes"
	/ "div"
	/ "element"
	/ "empty"
	/ "external"
	/ "grammar"
	/ "include"
	/ "inherit"
	/ "list"
	/ "mixed"
	/ "namespace"
	/ "notAllowed"
	/ "parent"
	/ "start"
	/ "string"
	/ "text"
	/ "token"

Char
	= [a-zA-Z]


NCName
	= Name //! ( Char * ":" Char * )
Name
	= NameStartChar NameChar*
Names
	= Name ( [\s]+ Name )*
Nmtoken
	= ( NameChar )+
Nmtokens
	= Nmtoken ( [\s]+ Nmtoken )*
NameStartChar
	= ":"
	/ [A-Z]
	/ "_"
	/ [a-z]
NameChar
	= NameStartChar / "-" / "." / [0-9] 

ws = " " / '\t' / '\n' / '\r'

eol = '\n'

	
// vim: ft=javascript
