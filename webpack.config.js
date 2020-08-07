const path = require('path');

module.exports = {
	target: 'node',
	entry: './src/comment.coffee',
	output: {
		path: path.resolve(__dirname, 'dist'),
		filename: 'index.js',
		libraryTarget: 'umd'
	},
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