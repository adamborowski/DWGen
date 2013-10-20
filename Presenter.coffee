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
header = (s)->
	l = ""
	for i in [1..s.length + 6]
		l += "-"
	"\n#{l}\n-- #{s} --\n#{l}\n"
line = (s)->
	str += "#{s}\n"
exports.writeSQL = (erd)->
	line header 'RESTAURACJE'
	for r in erd.Restauracja
		line "INSERT INTO Restauracja VALUES (#{r.id}, '#{r.nazwa}', '#{r.adres}', #{r.godzina_otwarcia}, #{r.godzina_zamkniecia}, #{r.liczba_miejsc})"
	line header 'KELNERZY'
	for r in erd.Kelner
		line "INSERT INTO Kelner VALUES (#{r.id}, '#{r.nazwisko}', '#{r.imie}', #{r.data_zatrudnienia}, #{r.restauracja.id})"
	save()



