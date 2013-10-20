dateUtils = require 'date-utils'
Utils= require './Utils.js'
libxmljs= require 'libxmljs'
fs=require 'fs'
xml=libxmljs.parseXmlString((fs.readFileSync './xmlSource.xml'))
print = console.log
#
genToken= ->
	str=""
	for i in [1..10]
		str+=String.fromCharCode('A'.charAt(0)+Utils.random.integer 24)
	return str
#
dostawcy =
	uslugi: []
	znizki: []
exports.simulate = (config, erd)->
	restaurante=xml.get 'uslugi/firma[@nazwa="Restaurante"]'
	restauranteId=restaurante.attr('id').value()

	znizki=xml.find 'znizki/firma/znizka[@firma="'+restauranteId+'"]'
	for znizka in znizki
		from=znizka.get('oferowane').attr('od').value()
		to=znizka.get('oferowane').attr('do').value()
		zasieg=new RegExp znizka.get('zasieg').text()
		kategorie= (k for k in erd.Kategoria when zasieg.test k.nazwa)
		console.log("from, to:", from, to, (k.nazwa for k in kategorie));
		console.log("genToken():", genToken());
	console.log("restaurante:", restauranteId);
	console.log("znizka:", znizki.length);


