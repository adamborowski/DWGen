print = console.log
Utils = require './Utils.js'
#
mscPerDay = 1000 * 60 * 60 * 24
erd = undefined
config = undefined
Kategoria = undefined
restaurantConfig = undefined
swing = undefined
restaurant = undefined
#
testCategory = undefined
ZamowienieLastId=0

#
exports.init = (_config, _erd, _restaurant)->
	erd = _erd
	config = _config
	Kategoria = erd.Kategoria
	restaurantConfig = config.erd.restaurant
	swing = restaurantConfig.swing
	restaurant = _restaurant
	testCategory = Kategoria.filter((kat)->
		kat.id == 'pizza'
	)[0]
exports.finish = ()->
	return true #bez wykresu
	fs = require("fs")
	highcharts = require("node-highcharts")
	options =
		chart:
			width: 1500
			height: 500

		legend:
			enabled: false

		title:
			text: "dzienna sprzedaż w kategorii #{testCategory.nazwa} na przestrzeni czasu generatora"

		series: [
			data: day.numSales for day in testCategory.daySales
		]
	highcharts.render options, (err, data) ->
		if err
			console.log "Error: " + err
		else
			if fs.exists "chart.png"
				fs.remove 'chart.png'
			fs.writeFile "chart.png", data, ->
				console.log "Written to chart.png"

exports.simRange = (range, erd, config)->
#	console.log("symulowanie rangi:", range.toString());
	rangeEnd = range.to
	currentDate = new Date(range.from)
	numDays = 0
	while currentDate <= rangeEnd
		if range.changeAtStart? and numDays <= range.changeAtStart.duration
			simChange range.changeAtStart
		simDay currentDate
		#
		currentDate.addDays(1)
		numDays++

	return

simChange = (change)->
#	console.log "sim change: #{change.when.toDayString()} #{change.category}"
	for kategoria in Kategoria when change.category.test kategoria.id
#		console.log "SIM CHANGE W KATEGORII " + kategoria.id
		kategoria.dailySaleBase += change.addition / change.duration

simDay = (date, erd)->
#	console.log 'simulation of ordinary day ' + date.toDayString()
	# oblicz przyrost dzienny
	daily = Math.random() * (swing.highLimit - swing.lowLimit) + swing.lowLimit
	addition = swing.addFuncion(date.getTime() / mscPerDay)
	for kategoria in Kategoria
		kategoria.dailySaleBase *= daily
		kategoria.dailySaleAddition = addition
		kategoria.dailySale = kategoria.dailySaleBase + kategoria.dailySaleAddition
		#	console.log("addition:", addition);
		#	console.log("dailySwing:", Kategoria[0].dailySale);
		kategoria.daySales.push
			date: new Date date
			numSales: Math.floor(kategoria.dailySale)
	generateDailyOrders date, Kategoria[0].daySales.length - 1
generateDailyOrders = (date, daySalesIndex)->
#	print "generate daily orders: #{date.toDayString()}"
	#przejrzyj kategorie
	remainingSales = ({kategoria: kategoria, numSales: kategoria.daySales[daySalesIndex].numSales} for kategoria in Kategoria)
	sumSales = remainingSales.reduce (sum, sale)->
		sum + sale.numSales
	, 0
	#	print "pozostało do wykorzystania: #{sale.kategoria.id}: #{sale.numSales}" for sale in remainingSales
	avgOrderSize = config.erd.restaurant.avgOrderSize
	numOrders = Math.round(sumSales / avgOrderSize)
	#najpierw generuj same zamówienia
	restaurantOpen = restaurant.godzina_otwarcia
	restaurantClose = restaurant.godzina_zamkniecia
	genTime = ->
		hh = Utils.random.integer(restaurantOpen, restaurantClose)
		mm = Utils.random.integer(0, 60)
		genDate = new Date(date)
		genDate.setHours hh
		genDate.setMinutes mm
		return genDate
	DailyOrder = []
	for i in [1..numOrders]
		orderTime = genTime()
		makeDuration = Utils.random.float config.erd.restaurant.minWaitMinutes, config.erd.restaurant.maxWaitMinutes
		dailyOrder =
			id: ZamowienieLastId++
			data_przyjecia: orderTime
			data_platnosci: new Date(orderTime).addMinutes makeDuration
			kelner: Utils.random.arrayItem restaurant.kelnerzy
			numer_stolika: Utils.random.integer restaurant.liczba_miejsc
			platnosc: Utils.random.arrayItem config.erd.payments
			kod_rabatu: null
			pozycje: {} # kluczem jest id produktu, wartością jest ref do dania oraz iloć porcji oraz cena/porcja
			toString: ->
				str = @data_platnosci.toTimeString() + " odebrane przez: #{@kelner.imie} #{@kelner.nazwisko}"
				for key, poz of @pozycje
					str += "\n\t- #{poz.danie.nazwa}: #{poz.porcja}"

				return str
		#
		#
		DailyOrder.push dailyOrder
	#
	DailyOrder.sort (a, b)->
		return -1  if a.data_przyjecia < b.data_przyjecia
		return 1  if a.data_przyjecia > b.data_przyjecia
		0
	# mamy puste zamówienia oraz liczniki kategorii
	# wsadzaj losowe danie do losowego zamówienia
	iloscDodanychDan = 0
	dodajDanieDoZamowienia = (danie, zamowienie)->
		iloscDodanychDan++
		id = danie.id
		if zamowienie.pozycje[id]?
			zamowienie.pozycje[id].porcja++
		else
			zamowienie.pozycje[id] =
				danie: danie
				zamowienie: zamowienie
				cena: danie.cena
				porcja: 1
	wybierzJakiesDanie = ->
		#wybierz jakąś kategorię
		chosenCategory = Utils.random.arrayItem remainingSales
		#wybierz danie z kategorii
		chosenDish = Utils.random.arrayItem chosenCategory.kategoria.dania
		# jeśli już ta kategoria jest pusta, to usuń ją z remaining
		chosenCategory.numSales-- # wykorzystaj danie z tej kategorii
		if chosenCategory.numSales == 0
			Utils.array.removeUnordered(remainingSales, chosenCategory)
		return chosenDish
	#na początku każde zamówienie musi mieć jedno jakieś danie
	for dailyOrder in DailyOrder
		dodajDanieDoZamowienia wybierzJakiesDanie(), dailyOrder
	#potem mozna losowane dania dodawac do losowych zamówień
	while remainingSales.length
		dodajDanieDoZamowienia wybierzJakiesDanie(), Utils.random.arrayItem DailyOrder

	#	print dailyOrder.toString() for dailyOrder in DailyOrder
	#	print 'dan sprzedanych: ', iloscDodanychDan, 'sum sales: ',sumSales
	for dailyOrder in DailyOrder
		erd.Zamowienie.push dailyOrder
		pozycjeTab = []
		c = 0
		for id, poz of dailyOrder.pozycje
			pozycjeTab.push poz
			erd.ZamowienieProdukt.push poz
			poz.nr = c
			c++
		dailyOrder.pozycje = pozycjeTab