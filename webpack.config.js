const path = require('path');

module.exports = {
	target: 'node',
	entry: './src/comment.coffee',
	mode: 'production',
	module: {
		rules: [
			{
				test: /\.coffee$/,
				loader: 'coffee-loader'
			}
		]
	}
};