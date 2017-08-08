# XML to JSON (XSLT 1.0)
XSLT 1.0 stylesheet to transform XML representation of JSON to JSON as text.

Loosely offering functionality available in XSLT 3.0 fn:xml-to-json() where this is not available natively in XSLT 1.0 or XSLT 2.0. Note this approach  is XSLT stylesheet based rather than XSLT function.
http://www.w3.org/TR/xpath-functions-31/#func-xml-to-json

The stylesheet input is XML representation of JSON. The initial processing within the stylesheet transforms the input XML to AST format representation for JSON as on json.org. This initial processing stored as a variable is then simply outputted as string with xsl:value-of to leave behind JSON as text.

"In computer science, an abstract syntax tree (AST), or just syntax tree, is a tree representation of the abstract syntactic structure of source code  written in a programming language. Each node of the tree denotes a construct occurring in the source code."
https://en.wikipedia.org/wiki/Abstract_syntax_tree

Use $debug-ast stylesheet parameter to observe intermediate AST XML format.    

No current provision to customise JSON format and indent.
