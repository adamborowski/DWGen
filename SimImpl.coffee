simulation = []
mscPerDay = 1000 * 60 * 60 * 24
erd = undefined
config = undefined
Kategoria = undefined
restaurantConfig = undefined
swing = undefined
#
test = []
testCategory = undefined

#
exports.init = (_config, _erd)->
	erd = _erd
	config = _config
	Kategoria = erd.Kategoria
	restaurantConfig = config.erd.restaurant
	swing = restaurantConfig.swing
	test = []
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
	console.log("symulowanie rangi:", range.toString());
	rangeEnd = range.to
	currentDate = new Date(range.from)
	numDays = 0
	while currentDate <= rangeEnd
		if range.changeAtStart? and numDays <= range.changeAtStart.duration
			simChange range.changeAtStart
		simOrdinalDay currentDate
		#
		currentDate.addDays(1)
		numDays++

	return

simChange = (change)->
	console.log "sim change: #{change.when.toDayString()} #{change.category}"

	for kategoria in Kategoria when change.category.test kategoria.id
#		console.log "SIM CHANGE W KATEGORII " + kategoria.id
		kategoria.dailySaleBase += change.addition / change.duration

simOrdinalDay = (date, erd)->
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
			numSales: kategoria.dailySale

