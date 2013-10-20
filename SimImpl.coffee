simulation = []
erd = undefined
config = undefined
Kategoria = undefined
restaurantConfig = undefined
swing = undefined
#
exports.init = (_config, _erd)->
	erd = _erd
	config = _config
	Kategoria = erd.Kategoria
	restaurantConfig = config.erd.restaurant
	swing = restaurantConfig.swing
exports.simRange = (range, erd, config)->
	console.log("symulowanie rangi:", range.toString());
	rangeEnd = range.to
	currentDate = new Date(range.from)
	numDays = 0
	while currentDate <= rangeEnd
		currentDate.addDays(1)
		numDays++
		simOrdinalDay currentDate

	if range.changeAtEnd?
		console.log "zmiana: #{range.changeAtEnd.when.toDayString()}"
	else
		console.log "nie ma następnej zmiany"
	#	console.log(numDays);
	return

simOrdinalDay = (date, erd)->
	console.log 'simulation of ordinary day ' + date.toDayString()
	# oblicz przyrost dzienny
	daily = Math.random() * swing.highLimit - swing.lowLimit + swing.lowLimit
	console.log("dailySwing:", daily);
