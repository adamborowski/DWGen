// Generated by CoffeeScript 1.6.3
(function() {
  var dateUtils, dostawcy, fs, print, xml;

  dateUtils = require('date-utils');

  fs = require('fs');

  xml = fs.readFile('./xmlSource.xml');

  print = console.log;

  dostawcy = {
    uslugi: [],
    znizki: []
  };

  exports.simulate = function(config, erd) {
    return print(xml);
  };

}).call(this);

/*
//@ sourceMappingURL=DiscountsSimulator.map
*/