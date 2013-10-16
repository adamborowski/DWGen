services: [
	food:
		"Alkohol po godzinach": [
			"alkohol"
		]
		"Wieczorem taniej": [
			"mięsne"
			"napoje"
			"desery"
			"sałatki"
		]
		"Weekendowa Pizza": [
			"pizza"
			"napoje"
		]
		"Makarony za pół ceny": [
			"makarony"
		]
	entertainment: [
		"Godzina kręgli": [
			"kręgle"
		]
		"Piątkowy student": [
			"alkohol"
			"kręgle"
			"bilart"
			"darts"
			"kino"
		]
	]
	medical: [
		"Daj przyjemność oku badaniem wzroku": [
			"badanie_okulista"
		]
		"Dla abonentów": [
			"wizyta_internista"
			"wizyta_laryngolog"
			"wizyta_kardiolog"
			"badanie_usg"
			"badanie_usg"
		]
	]
	transport: [
		"Jazda nocą": [
			"bus"
			"pociąg_ekspres"
			"pociąg_intercity"
			"autokar"
		]
		"Wybierz szyny": [
			"pociąg_ekspres"
			"pociąg_intercity"
		]
	]
]
providers =
	discont: [
		'Grupon'
		'EmBank'
		'eSKaeM'
		'EsKaEm'
	]
# refrencje do kategorii dań
c =
	alkohol: {nazwa: 'alkohol', jednostka: 'ml', opis: 'palące w ustach trunki oraz te wyrafinowane - wszystko czego pragnie alkoholowy smakosz'}
	napoje: {nazwa: 'napoje', jednostka: 'ml', opis: 'coś do wypicia na ciepło i na zimno'}
	miesne: {nazwa: 'mięsne', jednostka: 'g', opis: 'mięcho na obiad'}
	przekaski: {nazwa: 'przekąski', jednostka: 'g', opis: 'podawane przed obiadem'}
	pizza: {nazwa: 'pizza', jednostka: 'g', opis: 'smaczna pizza'}
	makar: {nazwa: 'makarony', jednostka: 'g', opis: 'pełen asortyment włoskich makaronów - wszystkie al\' dente'}
# słownik dań |nazwa porcja cena_za_porcje kategoria|
#TODO Rzymek, mógłbyś dodać tutaj trochę dań?
dania: [
	['Margerita', 24, 400, c.pizza]
	['Capricciosa', 23, 400, c.pizza]
	['Fungi', 23, 400, c.pizza]
	['Wiejska', 23, 400, c.pizza]
	#
	['herbata', 6, 400, c.napoje]
	['kawa', 8, 300, c.napoje]
	#
	['oscypek z żurawiną', 32, c.przekaski]

]
###
    PUBLIC EXPORT
###
exports.providers = providers