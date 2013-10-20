exports.config =
	discount:
		numProviders: 300

	erd:
		restaurantNames: [
			"U Romka"
			"U Tomka"
			"U Grzesia"
			"U Fabiana"
			"U Maćka"
			"U Jakuba"
			"U Marzenny"
			"U Patrycji"
			"U Filipa"
			"U Michała"
			"U Gabriela"
			"U Szymona"
			"U Anieli"
		]
		hireDate: "2012-09-01"
		restaurant:
			simStart: new Date('2006-10-24')
			simEnd: new Date('2010-09-27')
			openTime: [7, 9]
			closeTime: [19, 22]
			minCapacity: 22
			maxCapacity: 82
			avgOrderSize:4
			minWaitMinutes: 5 # minimum minut czeania na jedną pozycję w zamówieniu
			maxWaitMinutes: 12 # maximum minut czeania na jedną pozycję w zamówieniu
			initialSalesRatio: 0.56 # kategoria w danej restauracji ma sprzedaż initialSalesRatio*liczba_miejsc
			swing: #dzienny przyrost zamówień, tutaj widać tendencję ciągłego przyrostu
				lowLimit: 0.998 #minimalnie spadek dzienny 1 promil
				highLimit: 1.0035 # maksymalnie wzrost dzienny 2 promile
				addFuncion: (day)->
					3 * (Math.sin(0.3 * day) + 0.3 * Math.sin(day * 1.446)) * Math.sin(day / 20) * Math.sin(day / 100)
			changes: [
				{
				#święta Bożego Narodzenia, ludzie jedzą w domu z rodziną
					when: new Date('2009-12-04')
					category: /.*/
					addition: -30
					duration: 10 # przez tyle dni będzie się zmieniać o addition/duration
				}
				{
				#po sezonie świątecznym, ludzie wracają do restauracji
					when: new Date('2010-01-04')
					category: /.*/
					addition: 30
					duration: 5
				}
				{
				#wprowadzono zniżki na pizze
					when: new Date('2007-04-03')
					category: /pizza/
					addition: 38
					duration: 18
				}
			]
