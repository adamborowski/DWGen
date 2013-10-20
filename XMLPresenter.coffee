fs = require 'fs'
NAME = 'discounts.xml'
str = ""
save = ->
	fs.remove NAME if fs.exists NAME
	fs.writeFile NAME, str, (err) ->
		if err
			console.log err
		else
			console.log "The file was saved to #{NAME}"
exports.writeXML = (discounts)->
	null