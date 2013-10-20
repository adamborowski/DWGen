dateUtils = require 'date-utils'
Utils = require './Utils.js'
libxmljs = require 'libxmljs'
fs = require 'fs'
xml = libxmljs.parseXmlString((fs.readFileSync './xmlSource.xml'))
print = console.log
#
NAME = "discounts.xml"
save = ->
	fs.remove NAME if fs.exists NAME
	fs.writeFile NAME, xml.toString(), (err) ->
		if err
			console.log err
		else
			console.log "The file was saved to #{NAME}"

#
genToken = ->
	str = ""
	for i in [1..16]
		str += String.fromCharCode(65 + Utils.random.integer 26)
	return str
#
dostawcy =
	uslugi: []
	znizki: []
exports.simulate = (config, erd)->
	kodyDoWykorzystania = []
	restaurante = xml.get 'uslugi/firma[@nazwa="Restaurante"]'
	restauranteId = restaurante.attr('id').value()

	znizki = xml.find 'znizki/firma/znizka[@firma="' + restauranteId + '"]'
	for znizka in znizki
		daty = znizka.find 'oferowane'
		zasieg = new RegExp znizka.get('zasieg').text()
		kategoria = (erd.Kategoria.filter (c)->
			zasieg.test c.nazwa)[0]
		tokeny = znizka.get 'tokeny'
		#		kategorie= (k for k in erd.Kategoria when zasieg.test k.nazwa)
		for data in daty
			from = data.attr('od').value()
			to = data.attr('do').value()
			generuj = parseInt(data.attr('generuj').value())
			for i in [1..generuj]
				kod = genToken()
				tokeny.node('token').attr
					kod: kod
					od: from
					do: to
				kodyDoWykorzystania.push
					kategoria: kategoria
					token: kod
					od: new Date(from)
					do: new Date(to)

	save()
	return kodyDoWykorzystania


