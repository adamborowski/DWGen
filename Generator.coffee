config = require "./config.json"
data = require './Data.js'
utils = require './Utils.js'
################################################
#--------- ETAP PIERWSZY ---- GENERACJA
for i in [1..config.discount.numProviders]
	console.log("utils.random.companyName():", utils.random.companyName());



