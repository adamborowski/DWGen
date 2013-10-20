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
			numSales: 23 # z każdej
			swing: #dzienny przyrost zamówień, tutaj widać tendencję ciągłego przyrostu
				lowLimit: 0.999 #minimalnie spadek dzienny 1 promil
				highLimit: 1.002 # maksymalnie wzrost dzienny 2 promile
			changes: [
				{
				#święta Bożego Narodzenia, ludzie jedzą w domu z rodziną
					when: new Date('2009-12-04')
					ratio: 0.6
					category: /.*/
				}
				{
				#po sezonie świątecznym, ludzie wracają do restauracji
					when: new Date('2010-01-04')
					ratio: 1/0.6
					category: /.*/
				}
				{
					#wprowadzono zniżki na pizze
					when: new Date('2007-04-03')
					ratio: 1.7
					category: /pizza/
				}
			]
