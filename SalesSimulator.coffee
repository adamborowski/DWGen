dateUtils = require 'date-utils'
simImpl=require './SimImpl.js'

compare = (a, b) ->
	return -1  if a.when < b.when
	return 1  if a.when > b.when
	0
# tworzenie chronologicznej tablicy przediałów pomiędzy zmianami
generateRanges = (simStart, simEnd, changes)->
	ranges = []
	ranges.push
		from:new Date simStart
		to:(new Date changes[0].when).addDays -1 #  na dzien przed pierwsza zmiana
		changeAtStart:undefined
	for change, index in changes
		from = new Date(change.when)
		if changes[index+1]?
			to=new Date(changes[index+1].when).addDays -1
		else
			to = new Date(simEnd)
		# from i to są włączone w dni rutynowe
		ranges.push
			from: from
			to: to
			changeAtStart: change
	for range in ranges
		range.toString = ->
			"range: od #{@from.toDayString()} do #{@to.toDayString()} zmiana początkowa: #{if @changeAtStart? then @changeAtStart.when.toDayString() else '[nic]'}"
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
	category.dailySaleBase = config.erd.restaurant.initialSalesRatio*restaurant.liczba_miejsc for category in erd.Kategoria
	category.daySales = [] for category in erd.Kategoria
	simStart = config.erd.restaurant.simStart
	simEnd = config.erd.restaurant.simEnd

	#podziel obszary czasu
	ranges = generateRanges simStart, simEnd, changes
	simImpl.simRange range, erd for range in ranges

#	for kategoria in erd.Kategoria
#		console.log "#{kategoria.id} - #{day.date.toDayString()} - #{Math.floor(day.numSales)}" for day in kategoria.daySales
	# TERAZ można wygenerować zamówienie, korzystając z dziennych ilości kategorii

exports.simulate = (config, erd)->
	for restaurant in erd.Restauracja[0..0]
		simImpl.init config, erd, restaurant
		simRestaurant restaurant, config, erd



	simImpl.finish()


