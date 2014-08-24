var PEG = require("pegjs"),
	fs = require("fs"),
	Promise = require("bluebird")
;


function readSchema(input, func) {
	var remaining = '', schema = "";

	function handle(line) {
		if (line.trim() == '') {
			return;
		}
		if (line.trim().indexOf("#") == 0) {
			return;
		}
		schema += line + '\n';
	}

	input.on('data', function(data) {
		remaining += data;
		var index = remaining.indexOf('\n');
		while (index > -1) {
			var line = remaining.substring(0, index);
			remaining = remaining.substring(index + 1);
			handle(line);
			index = remaining.indexOf('\n');
		}
	});

	return new Promise(function(resolve, reject) {
		input.on('end', function() {
			if (remaining.length > 0) {
				handle(remaining);
			}
			resolve(schema);
		});
	});
}

var 
	schemaFile = "var/example/park-hikes.rnc",
	schemaFile = 'var/example/test.rnc',
	input = fs.createReadStream(schemaFile),
	schema = readSchema(input),

	grammarFile = 'var/rnc.pegjs',
	grammarFile = 'var/test.pegjs',
	grammar_str = fs.readFileSync(grammarFile, {encoding: 'ascii'}),
	parser = PEG.buildParser(grammar_str)
;

schema.then(function(data) {

	var out = parser.parse( data );
	console.log(out);

});


// PEGjs example
//var grammar_str = "start = ('a' / 'b')+";
//parser.parse("abba"); // returns ["a", "b", "b", "a"]
//parser.parse("abcd"); // throws an exception 


