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
  for i in erd.Kelner
    line "INSERT INTO Kelnerzy VALUES (#{i.id}, #{i.restauracja.id}, '#{i.nazwisko}', '#{i.imie}', '#{i.data_zatrudnienia}')"

  line header 'KATEGORIE'
  for i in erd.Kategoria
    line "INSERT INTO Kategorie VALUES (#{i.id}, '#{i.nazwa}', '#{i.opis}')"

  line header 'DANIA'
  for i in erd.Danie
    line "INSERT INTO Dania VALUES (#{i.id}, #{i.kategoria.id}, '#{i.nazwa}', #{i.cena}, #{i.porcja}, '#{i.kategoria.jednostka}')"

  save()




