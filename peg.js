var PEG = require("pegjs"),
	fs = require("fs")
;

// PEGjs example
//var grammar_str = "start = ('a' / 'b')+";
//parser.parse("abba"); // returns ["a", "b", "b", "a"]
//parser.parse("abcd"); // throws an exception 


var grammar_str = fs.readFileSync('var/rnc.pegjs', {encoding: 'ascii'});
var parser = PEG.buildParser(grammar_str);

//parser.parse( fs.readFileSync("var/example/park-hikes.rnc", {encoding: 'ascii'}) )

data = fs.readFileSync("var/example/park-hikes.named.rnc", {encoding: 'ascii'})
parser.parse( data )


