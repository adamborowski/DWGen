config = require "./config.json"
data = require './Data.js'
utils = require './Utils.js'
charlatan=require 'charlatan'
charlatan.setLocale 'pl'
################################################
#--------- ETAP PIERWSZY ---- GENERACJA
#for i in [1..config.discount.numProviders]
#	console.log("utils.random.companyName():", utils.random.companyName());
restaurants=[]
for name, i in config.erd.restaurantNames
	restaurants.push
		id: i
		nazwa: name
		adres: "#{charlatan.Address.streetAddress()}, #{charlatan.Address.zipCode()} #{charlatan.Address.city()}"
		godzina_otwarcia:utils.random.integer(7, 9)
		godzina_zamkniecia:utils.random.integer(19, 22)
		liczba_miejsc: utils.random.integer(22, 82)

console.log("restaurants:", restaurants);


