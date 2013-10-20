Date::toDayString = ->
	m = @getMonth() + 1
	m = "0" + m if m < 10
	d = @getDate()
	d = "0" + d if d < 10
	"#{@getFullYear()}-#{m}-#{d}"
dateUtils = require 'date-utils'
compare = (a, b) ->
	return -1  if a.when < b.when
	return 1  if a.when > b.when
	0
Math.log = (->
	log = Math.log
	(n, base) ->
		log(n) / ((if base then log(base) else 1)))()
names =
	food: [
		"Restaurante"
		"Pizzerina"
		"U Tobiasza"
		"Grzane odgrzewane"
		"McTusk"
		"Swojski zapach"
		"Klasyka smaku"
	]
	entertainment: [
		"3'Ball Center"
		"U7"
		"Centrum Handlowe Beta"
	]
	medical: [
		"SwissMet"
		"Germedica"
		"Altenpflege Pro"
	]
randomParts = "super pos hub muss hajo lobo hyper uber kalo new rich wed mon ptero tera giga mini gust serwis strefa zatoka kraina eden".split " "
_generatedCompanies = {}
utils =
	array:
		removeUnordered: (array, item)->
			index=array.indexOf(item)
			array[index]=array[array.length-1] #podmiana tego z końca z tym usuwanym ze środka
			array.pop()
	random:
		integer: (from, to = null)->
			unless from? # jeśli nie podano from, to chodzi o zakres (0,..)
				to = from
				from = 0
			return Math.floor (Math.random() * (to - from) + from)
		float: (from, to=null)->
			unless from? # jeśli nie podano from, to chodzi o zakres (0,..)
				to = from
				from = 0
			return Math.random() * (to - from) + from
		companyName: (category = "food")->
			set = names[category]
			while yes
				if Math.random() < 0.10
					newName = set[utils.random.integer set.length]
				else
					ret = []
					prefixIndex = utils.random.integer(randomParts.length)
					ret.push randomParts[prefixIndex]

					suffixIndex = utils.random.integer(randomParts.length - 1) # pierwszy już był wybrany
					suffixIndex++ if suffixIndex >= prefixIndex # przesuwamy aby nie powtórzył się
					ret.push set[utils.random.integer set.length] if Math.random() < .2
					ret.push randomParts[suffixIndex]
					newName = ret.join ' '
				if _generatedCompanies[newName] == undefined
					_generatedCompanies[newName] = yes
					return newName
		arrayItem: (array)->
			array[Math.floor(Math.random() * array.length)]
# powtarzaj do skutku

for key, value of utils
	exports[key] = value


