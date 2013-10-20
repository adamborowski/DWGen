config = require "./config.js"
for name of config.config
	config[name] = config.config[name]
#
data = require './Data.js'
#
utils = require './Utils.js'
#
charlatan = require 'charlatan'
charlatan.setLocale 'pl'
#
simulator = require './SalesSimulator.js'
################################################
#--------- ETAP PIERWSZY ---- GENERACJA DANYCH z configu + elementy losowe
#(--------- ETAP DRUGI ------- tworzenie reprezentacji, np w SQL)
Restauracja = []
Kelner = []
Kategoria = []
Danie = []
Zamowienie = []
ZamowienieProdukt = []
ERD =
	Restauracja: Restauracja
	Kelner: Kelner
	Kategoria: Kategoria
	Danie: Danie
	Zamowienie: Zamowienie
	ZamowienieProdukt: ZamowienieProdukt
	id: (entity)->
		entity.length + 1
#

for key, kategoria_data of data.kategorie
	kategoria_data.id = key
	Kategoria.push kategoria_data
	kategoria_data.dania = []

for key, danie_data of data.dania
	danie =
		id: ERD.id(Danie)
		nazwa: danie_data[0]
		cena: danie_data[1]
		porcja: danie_data[2]
		kategoria: danie_data[3]
	danie.kategoria.dania.push danie
	Danie.push danie

for name, i in config.erd.restaurantNames
	#tworzenie restauracji
	restauracja =
		id: ERD.id(Restauracja)
		nazwa: name
		adres: "#{charlatan.Address.streetAddress()}, #{charlatan.Address.zipCode()} #{charlatan.Address.city()}"
		godzina_otwarcia: utils.random.integer(config.erd.restaurant.openTime[0], config.erd.restaurant.openTime[1])
		godzina_zamkniecia: utils.random.integer(config.erd.restaurant.closeTime[0], config.erd.restaurant.closeTime[1])
		liczba_miejsc: utils.random.integer(config.erd.restaurant.minCapacity, config.erd.restaurant.maxCapacity)
		kelnerzy: []
	Restauracja.push restauracja
	#przydzielanie kelnerów
	numWaiters = Math.ceil(Math.random() * 0.1 + 0.95 * restauracja.liczba_miejsc / 8)
	for j in [1..numWaiters]
		kelner =
			id: ERD.id(Kelner)
			restauracja: restauracja
			imie: charlatan.Name.firstName()
			nazwisko: charlatan.Name.lastName()
			data_zatrudnienia: config.erd.hireDate
		Kelner.push kelner
		restauracja.kelnerzy.push kelner

#console.log("Restauracja:", Restauracja);
#console.log("Kelner:", Kelner);
#console.log("Kategoria:", Kategoria);
#console.log("Danie:", Danie);
simulator.simulate config, ERD
presenter= require './Presenter.js'
presenter.writeSQL ERD
