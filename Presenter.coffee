fs = require 'fs'
NAME = 'insert.sql'
str = ""
save = ->
	fs.remove NAME if fs.exists NAME
	fs.writeFile NAME, str, (err) ->
		if err
			console.log err
		else
			console.log "The file was saved to #{NAME}"
line = (s)->
	str += "#{s}\n"
exports.writeSQL = (erd)->
	for r in erd.Restauracja
		line "INSERT INTO Restauracja VALUES (#{r.id}, '#{r.nazwa}', '#{r.adres}', #{r.godzina_otwarcia}, #{r.godzina_zamkniecia}, #{r.liczba_miejsc})"
	save()



