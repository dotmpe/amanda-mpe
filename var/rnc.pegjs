/* Work-in-progress on RNC syntax 

- EBNF syntax for RNC https://www.oasis-open.org/committees/relax-ng/compact-20021121.html

- Left hand recursion occuring in commented out blocks. 
  Trying to get parser going.
- Comments are not parsed, filtered.
- Need to fix whitesspace, translate codes to JS 
*/

start = topLevel

empty = [\s]* eol
comment = "#" [^\n]* eol

eol = "\n"

// topLevel  ::=  	decl* (pattern | grammarContent*)
topLevel = decl* ( pattern / grammarContent* )


decl
	= ( "namespace" identifierOrKeyword "=" namespaceURILiteral )
	/ ( "default" "namespace" identifierOrKeyword ? "=" namespaceURILiteral )
	/ ( "datatypes" identifierOrKeyword "=" literal )

pattern 
	= ( "element" nameClass "{" pattern "}" )
	/ ( "attribute" nameClass "{" pattern "}" )
//	/ ( pattern ( "," pattern ) + )
//	/ ( pattern ( "&" pattern ) + )
//	/ ( pattern ( "/" pattern ) + )
//	/ ( pattern "?" )
//	/ ( pattern "*" )
//	/ ( pattern "+" )
//	/ ( "list" "{" pattern "}" )
//	/ ( "mixed" "{" pattern "}" )
	/ ( identifier )
	/ ( "parent" identifier )
	/ "empty"
	/ "text"
	/ ( datatypeName ? datatypeValue )
	/ ( datatypeName ( "{" param* "}" ) ? ( exceptPattern ) ? )
	/ "notAllowed"
	/ ( "external" anyURILiteral ( inherit ) ?  )
	/ ( "grammar" "{" grammarContent * "}" )
	/ ( "(" pattern ")" )

param
	= identifierOrKeyword "=" literal

exceptPattern
	= "-" pattern

grammarContent
	= startDecl
	/ define
	/ ( "div" "{" grammarContent* "}" )
	/ ( "include" anyURILiteral inherit ?  ( "{" includeContent* "}" ) ? )

includeContent
	= define
	/ startDecl
	/ ( "div" "{" includeContent* "}" )

startDecl
	= "start" assignMethod pattern

define
	= identifier assignMethod pattern

assignMethod
	= "="
	/ "|="
	/ "&="

nameClass
	= name
	/ ( nsName exceptNameClass ? )
	/ ( anyName exceptNameClass ? )
/*
	/ ( nameClass "|" nameClass )
	/ "(" nameClass ")"
*/

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
	= literalSegment ( "~" literalSegment ) +

literalSegment
	= ( '"' ( Char ! ('"' / newline ))* '"' )
	/ ( "'" ( Char ! ("'" / newline ))* "'" )
	/ ( '"""' ( '"' ? '"' ? ( Char ! '"' ))* '"""' )
	/ ( "'''" ( "'" ? "'" ? ( Char ! "'" ))* "'''" )

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
// Char   ::=   	#x9 | #xA | #xD | [#x20-#xD7FF] | [#xE000-#xFFFD] | [#x10000-#x10FFFF]	

newline
	= "\n"

NCName
	= Name 
//! ( Char * ":" Char * )
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
//NameStartChar   ::=   	":" | [A-Z] | "_" | [a-z] | [#xC0-#xD6] | [#xD8-#xF6] | [#xF8-#x2FF] | [#x370-#x37D] | [#x37F-#x1FFF] | [#x200C-#x200D] | [#x2070-#x218F] | [#x2C00-#x2FEF] | [#x3001-#xD7FF] | [#xF900-#xFDCF] | [#xFDF0-#xFFFD] | [#x10000-#xEFFFF]

NameChar
	= NameStartChar / "-" / "." / [0-9] 
	/// #xB7 / [#x0300-#x036F] / [#x203F-#x2040]
	
// vim: ft=javascript
