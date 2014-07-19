var amanda = require('amanda');

var jsonSchemaValidator = amanda('json');


/*
 * http://json-schema.org/latest/json-schema-validation.html#anchor88
 */
var schema = 
{
	$schema: '//',
	type: 'object',
	additionalProperties: false,
	properties: {
		name: {
			required: true,
			type: 'string'
		},
		bar: {
			type: 'integer',
			required: true,
			maximum: 5,
			maximumExclusive: true, // FIXME: not supported
			minimum: 2
		},
		baz: {
			type: 'object',
			required: true,
			properties: {
				id: { 
					type: 'integer',
					required: true,
					minimum: 9
				},
				type: {
					type: 'string',
					required: true,
					oneOf: [ // FIXME: not supported
						'bar'
					]
				}
			}
		},
		foo: {
			type: 'object',
			required: true,
			oneOf: [ // FIXME: not supported
				{ "$ref": "#/definitions/obj1"}
			]
		}
	},
	definitions: {
		"obj1": {
			properties: {
				id: { 
					type: 'integer',
					required: true,
					minimum: 9
				}
			}
		},
	},
	required: ['name', 'objects']
};
var data = 
{
	name: 'Kenneth',
	bar: 5,
	baz: {
		id: 10,
		type: 'foo'
	},
	foo: {
	},
	//x: {}
};

jsonSchemaValidator.validate(data, schema, function(error) {
	if (error) console.error(error);
	console.log('Validated');
});

