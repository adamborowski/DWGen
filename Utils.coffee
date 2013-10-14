names = [
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
]
randomParts = "super pos hub muss hajo lobo hyper uber kalo new rich wed mon ptero tera giga mini gust serwis strefa zatoka kraina eden".split " "
utils =
	random:
		integer: (from, to=null)->
			unless from? # jeśli nie podano from, to chodzi o zakres (0,..)
				to = from
				from = 0
			return Math.floor (Math.random() * (to - from) + from)
		companyName: (category="food")->
			set = names[category]
			debugger
			if Math.random() < 0.10
				return set[utils.random set.length]
			prefixIndex = utils.random.integer(randomParts.length)
			suffixIndex = utils.random.integer(randomParts.length - 1) # pierwszy już był wybrany
			suffixIndex++ if suffixIndex >= prefixIndex # przesuwamy aby nie powtórzył się
			if Math.random() < .2 then infix = " #{set[utils.random set.length]} " else ""
			return "#{randomParts[prefixIndex]}#{infix}#{randomParts[suffixIndex]}"

for key, value of utils
	exports[key] = value


