config = require "./config.js"
for name of config.config
	config[name] = config.config[name]
#
data = require './Data.js'
utils = require './Utils.js'
charlatan = require 'charlatan'
charlatan.setLocale 'pl'
################################################
#--------- ETAP PIERWSZY ---- GENERACJA DANYCH z configu + elementy losowe
#(--------- ETAP DRUGI ------- tworzenie reprezentacji, np w SQL)
Restauracja = []
Kelner = []
Kategoria = []
Danie = []
Zamowienie = []
ZamowienieProdukt = []
#

for key, kategoria_data of data.kategorie
	Kategoria.push kategoria_data
for key, danie_data of data.dania
	danie =
		id: Danie.length + 1
		nazwa: danie_data[0]
		cena: danie_data[1]
		porcja: danie_data[2]
		kategoria: danie_data[3]
	Danie.push danie

for name, i in config.erd.restaurantNames
	#tworzenie restauracji
	restauracja =
		id: Restauracja.length + 1
		nazwa: name
		adres: "#{charlatan.Address.streetAddress()}, #{charlatan.Address.zipCode()} #{charlatan.Address.city()}"
		godzina_otwarcia: utils.random.integer(config.erd.openTime[0], config.erd.openTime[1])
		godzina_zamkniecia: utils.random.integer(config.erd.closeTime[0], config.erd.closeTime[1])
		liczba_miejsc: utils.random.integer(config.erd.minRestaurantCapacity, config.erd.maxRestaurantCapacity)
	Restauracja.push restauracja
	#przydzielanie kelnerów
	numWaiters = Math.ceil(Math.random() * 0.1 + 0.95 * restauracja.liczba_miejsc / 8)
	for j in [1..numWaiters]
		kelner =
			id: Kelner.length + 1
			restauracja: restauracja
			imie: charlatan.Name.name()
			nazwisko: charlatan.Name.lastName()
			data_zatrudnienia: config.erd.hireDate
		Kelner.push kelner

console.log("Restauracja:", Restauracja);
console.log("Kelner:", Kelner);
console.log("Kategoria:", Kategoria);
console.log("Danie:", Danie);


