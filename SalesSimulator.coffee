dateUtils = require 'date-utils'
simImpl=require './SimImpl.js'
compare = (a, b) ->
	return -1  if a.when < b.when
	return 1  if a.when > b.when
	0
# tworzenie chronologicznej tablicy przediałów pomiędzy zmianami
generateRanges = (simStart, simEnd, changes)->
	ranges = []
	from = undefined
	to = simStart.addDays -1 #trzeba odjąć, bo w pętli "from" ma dodawany jeden dzień na potrzeby change
	for change in changes
		from = to
		to = change.when
		ranges.push
			from: new Date(from).addDays 1
			to: new Date(change.when).addDays -1 # zmiana musi mieć osobny dzień!
			changeAtEnd: change
	ranges.push
		from: new Date(ranges[ranges.length - 1].changeAtEnd.when).addDays 1
		to: new Date(simEnd)
		changeAtEnd: undefined
	for range in ranges
		range.toString = ->
			"range: od #{@from.toDayString()} do #{@to.toDayString()} na koniec: #{if @changeAtEnd? then @changeAtEnd.when.toDayString() else '[nic]'}"
	return ranges

simRestaurant = (restaurant, config, erd)->
	console.log("SIMULATION '#{restaurant.nazwa}'");
	### PRZEBIEG SYMULACJI
	każdej kategorii przydziela się początkowe daily sales
	jeśli mamy jakąś zmianę zwględną, każdą kategorię przemnażamy razy ratio, o ile dana kategoria pasuje do REGEX
	czyli swing codziennie przemnaża jakąś kategorię
	a changes przemnaża tylko te kategorie pasujące do regex
	symulacja podzielona jest na kroki, które są wyznaczane przez daty zmian
	czyli zmiany należy przesortować zwględem daty zmian i na takie odcinki podzielić
	###
	changes = config.erd.restaurant.changes.sort compare
	category.dailySale = config.erd.restaurant.numSales for category in erd.Kategoria
	simStart = config.erd.restaurant.simStart
	simEnd = config.erd.restaurant.simEnd

	#podziel obszary czasu
	ranges = generateRanges simStart, simEnd, changes
	simImpl.simRange range, erd for range in ranges

#	currentDate=new Date(simStart)
#	numDays=0
#	while currentDate <=simEnd
#		console.log("currentDate:", currentDate);
#		currentDate.addDays(1)
#		numDays++
#
#	console.log(numDays);

exports.simulate = (config, erd)->
	simImpl.init config, erd
	simRestaurant restaurant, config, erd for restaurant in erd.Restauracja[0..0]


