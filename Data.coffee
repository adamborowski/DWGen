services: [
	food:
		"Alkohol po godzinach": ["alkohole"]
		"Wieczorem taniej": ["glowne", "napoje", "desery", "salatki"]
		"Weekendowa Pizza": ["pizza", "napoje"]
		"Makarony za pół ceny": ["makarony"]
	entertainment: [
		"Godzina kręgli": [
			"kręgle"
		]
		"Piątkowy student": [
			"alkohole"
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
	discount: [
		'Grupon'
		'EmBank'
		'eSKaeM'
		'EsKaEm'
	]
# refrencje do kategorii dań
c =
	alkohole:
		nazwa: "alkohole"
		jednostka: "ml"
		opis: "palące w ustach trunki oraz te wyrafinowane - wszystko czego pragnie alkoholowy smakosz"

	napoje:
		nazwa: "napoje"
		jednostka: "ml"
		opis: "coś do wypicia na ciepło i na zimno"

	przekaski:
		nazwa: "przekąski"
		jednostka: "g"
		opis: "podawane przed obiadem"

	pizza:
		nazwa: "pizza"
		jednostka: "g"
		opis: "smaczna pizza"

	przystZimne:
		nazwa: "Przystawki Zimne"
		jednostka: "g"
		opis: "na zimno"

	przystGorace:
		nazwa: "Przystawki Gorące"
		jednostka: "g"
		opis: "na gorąco"

	zupy:
		nazwa: "Zupy"
		jednostka: "ml"
		opis: "wszelakie zupy"

	makarony:
		nazwa: "Makarony"
		jednostka: "g"
		opis: "pełen asortyment włoskich makaronów - wszystkie aldente"

	glowne:
		nazwa: "Dania Główne"
		jednostka: "g"
		opis: ""

	desery:
		nazwa: "Desery"
		jednostka: "g"
		opis: ""

	salatki:
		nazwa: "Sałatki"
		jednostka: "g"
		opis: ""

# słownik dań |nazwa cena_za_porcje porcja kategoria|
dania = [
	['Piwo jasne', 7, 350, c.alkohole]
	['Piwo ciemne', 7, 350, c.alkohole]
	['Wódka czysta', 14, 100, c.alkohole]
	['Wino wytrawne czerwone', 18, 150, c.alkohole]
	['Wino wytrawne białe', 18, 150, c.alkohole]
	['Wino słodkie białe', 21, 150, c.alkohole]
	['Margerita', 24, 400, c.pizza]
	['Capricciosa', 23, 400, c.pizza]
	['Fungi', 23, 400, c.pizza]
	['Wiejska', 23, 400, c.pizza]
	['herbata', 6, 400, c.napoje]
	['kawa', 8, 300, c.napoje]
	['oscypek z żurawiną', 32, 130, c.przekaski]
	['Tatar z łososia norweskiego na ogórkowym carpaccio', 24, 150, c.przystZimne]
	['Balsamiczne polędwiczki drobiowe na sałatce z melonem i sosem curry', 19, 150, c.przystZimne]
	['Ruloniki orzechowej ricotty w płatkach wołowiny', 24, 100, c.przystZimne]
	['Tatar wołowy drobno siekany w towarzystwie grzybka i ogórka', 28, 200, c.przystZimne]
	['Carpaccio wołowe pod pierzynką rukolą i parmezanu', 25, 150, c.przystZimne]
	['Wykwintne scampi w oliwie z oliwek z czosnkiem i peperoncino', 31, 100, c.przystGorace]
	['Grzanka francuska z wątróbką i borowikami', 14, 120, c.przystGorace]
	['Krewetki królewskie w szynce parmeńskiej', 29, 100, c.przystGorace]
	['Consome drobiowe z warzywnym julienne', 8, 400, c.zupy]
	['Krem kalafiorowo-brokułowy', 10, 400, c.zupy]
	['Prowansalska zupa rybna', 17, 400, c.zupy]
	['Krem z dyni w aromacie gałki muszkatołowej', 9, 300, c.zupy]
	['Krem z leśnych grzybów zapiekany z ciastem francuskim', 18, 400, c.zupy]
	['Krem pomidorowy z delikatną mozzarellą', 11, 300, c.zupy]
	['Zupa pomidorowa z fikuśnym makaronikiem', 6, 200, c.zupy]
	['Rosół z lanymi kluseczkami', 6, 200, c.zupy]
	['Conchiglioni z borowikami i szpinakiem w pomidorach', 28, 400, c.makarony]
	['Fusilli avelinesi z trzema serami i orzechami włoskimi', 25, 350, c.makarony]
	['Tagliatelle z wędzonym łososiem', 24, 350, c.makarony]
	['Spaghetti z czosnkiem papryczką peperoncino i zieloną pietruszką', 20, 350, c.makarony]
	['Pappardelle ze szpinakiem i borowikami', 26, 300, c.makarony]
	['Spaghetti z frutti di mare w oliwie z oliwek', 33, 400, c.makarony]
	['Grillowany stek wołowy podany z cukiniami i opiekanymi ziemniaczkami', 53, 400, c.glowne]
	['Pierś kurczęca z suszonym pomidorkiem w parmeńskim płaszczyku w sosie gorgonzola podane z kopytkami', 36, 400,
	 c.glowne]
	['Polędwiczki wieprzowe z faszerowanym pomidorkiem w sosie gorczycowym z ziemniaczkami drążonymi', 38, 350,
	 c.glowne]
	['Skoki królicze z rulonikiem ziemniaczano – bekonowym i buraczkami zasmażanymi', 41, 330, c.glowne]
	['Marynowana pierś kacza z pierożkami gryczanymi i buraczkami', 40, 380, c.glowne]
	['Duet łososia i halibuta zawijany liść kapusty włoskiej z warzywnym risotto', 39, 320, c.glowne]
	['Filet z sandacza na warzywnym julienne w aksamitnym sosie czsnkowym z ziemniaczkami', 41, 310, c.glowne]
	['T-Bone steak z warzywamii z grilla i opiekanymi ziemniaczkami', 68, 320, c.glowne]
	['Kęski kurczaka w chrupiącej panierce z frytkami i surówka wiosenną', 18, 200, c.glowne]
	['Naleśniki z serem i owocami', 15, 200, c.glowne]
	['Pierożki własnej roboty  z jagodami', 18, 200, c.glowne]
	['Aksamitny torcik "monte bianco"', 15, 100, c.desery]
	['Tarta tatin na lustrze sosu karmelowego z lodami waniliowymi', 14, 100, c.desery]
	['Torcik czekoladowo-miętowy z łezką sosu truskawkowego', 14, 100, c.desery]
	['Krem Brulee', 14, 100, c.desery]
	['Panna Cotta z aksamitnym musem owocowym', 14, 90, c.desery]
	['Carpaccio z pomarańczy (lub innych owoców sezonowych) skropione nutą słodyczy', 10, 100, c.desery]
	['Deser lodowy', 10, 90, c.desery]
	['Sałatka Cezara', 26, 180, c.salatki]
	['Sałatka grecka', 23, 180, c.salatki]
	['Sałatka z mozzarellą, pomidorkami i bazylią zakrapiana salsą verde', 18, 150, c.salatki]
	['Bakłażan zapiekany nazłoto z mozzarellą i pomidorkami suszonymi serwowany na rucoli', 26, 200, c.salatki]
]
###
    PUBLIC EXPORT
###
exports.providers = providers
exports.kategorie = c
exports.dania = dania