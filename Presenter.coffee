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
  for k in erd.Kelner
    line "INSERT INTO Kelnerzy VALUES (#{k.id}, #{k.restauracja.id}, '#{k.nazwisko}', '#{k.imie}', '#{k.data_zatrudnienia}')"

  line header 'KATEGORIE'
  for k2 in erd.Kategoria
    line "INSERT INTO Kategorie VALUES (#{k2.id}, '#{k2.nazwa}', '#{k2.opis}')"

  line header 'DANIA'
  for d in erd.Danie
    line "INSERT INTO Dania VALUES (#{d.id}, #{d.kategoria.id}, '#{d.nazwa}', #{d.cena}, #{d.porcja}, '#{d.kategoria.jednostka}')"

  save()

