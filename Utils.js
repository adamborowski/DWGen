// Generated by CoffeeScript 1.6.3
(function() {
  var compare, dateUtils, key, names, randomParts, utils, value, _generatedCompanies;

  Date.prototype.toDayString = function() {
    var d, m;
    m = this.getMonth() + 1;
    if (m < 10) {
      m = "0" + m;
    }
    d = this.getDate();
    if (d < 10) {
      d = "0" + d;
    }
    return "" + (this.getFullYear()) + "-" + m + "-" + d;
  };

  Date.prototype.toTimeString = function() {
    var hh, mm;
    hh = this.getHours();
    if (hh < 10) {
      hh = "0" + hh;
    }
    mm = this.getMinutes();
    if (mm < 10) {
      mm = "0" + mm;
    }
    return "" + hh + ":" + mm;
  };

  dateUtils = require('date-utils');

  compare = function(a, b) {
    if (a.when < b.when) {
      return -1;
    }
    if (a.when > b.when) {
      return 1;
    }
    return 0;
  };

  Math.log = (function() {
    var log;
    log = Math.log;
    return function(n, base) {
      return log(n) / (base ? log(base) : 1);
    };
  })();

  names = {
    food: ["Restaurante", "Pizzerina", "U Tobiasza", "Grzane odgrzewane", "McTusk", "Swojski zapach", "Klasyka smaku"],
    entertainment: ["3'Ball Center", "U7", "Centrum Handlowe Beta"],
    medical: ["SwissMet", "Germedica", "Altenpflege Pro"]
  };

  randomParts = "super pos hub muss hajo lobo hyper uber kalo new rich wed mon ptero tera giga mini gust serwis strefa zatoka kraina eden".split(" ");

  _generatedCompanies = {};

  utils = {
    array: {
      removeUnordered: function(array, item) {
        var index;
        index = array.indexOf(item);
        array[index] = array[array.length - 1];
        return array.pop();
      }
    },
    random: {
      integer: function(from, to) {
        if (to == null) {
          to = null;
        }
        if (from == null) {
          to = from;
          from = 0;
        }
        return Math.floor(Math.random() * (to - from) + from);
      },
      float: function(from, to) {
        if (to == null) {
          to = null;
        }
        if (from == null) {
          to = from;
          from = 0;
        }
        return Math.random() * (to - from) + from;
      },
      companyName: function(category) {
        var newName, prefixIndex, ret, set, suffixIndex;
        if (category == null) {
          category = "food";
        }
        set = names[category];
        while (true) {
          if (Math.random() < 0.10) {
            newName = set[utils.random.integer(set.length)];
          } else {
            ret = [];
            prefixIndex = utils.random.integer(randomParts.length);
            ret.push(randomParts[prefixIndex]);
            suffixIndex = utils.random.integer(randomParts.length - 1);
            if (suffixIndex >= prefixIndex) {
              suffixIndex++;
            }
            if (Math.random() < .2) {
              ret.push(set[utils.random.integer(set.length)]);
            }
            ret.push(randomParts[suffixIndex]);
            newName = ret.join(' ');
          }
          if (_generatedCompanies[newName] === void 0) {
            _generatedCompanies[newName] = true;
            return newName;
          }
        }
      },
      arrayItem: function(array) {
        return array[Math.floor(Math.random() * array.length)];
      }
    }
  };

  for (key in utils) {
    value = utils[key];
    exports[key] = value;
  }

}).call(this);

/*
//@ sourceMappingURL=Utils.map
*/
