dateUtils = require 'date-utils'
fs=require 'fs'
xml=fs.readFile './xmlSource.xml'
print = console.log
#
dostawcy =
	uslugi: []
	znizki: []
exports.simulate = (config, erd)->
	print xml