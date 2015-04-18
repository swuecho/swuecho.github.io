
/*
js written number is copied from 
https://raw.githubusercontent.com/swuecho/js-written-number/master/lib/index.js

*/
var baseCardinals = {
  0: 'zero',
  1: 'one',
  2: 'two',
  3: 'three',
  4: 'four',
  5: 'five',
  6: 'six',
  7: 'seven',
  8: 'eight',
  9: 'nine',
  10: 'ten',
  11: 'eleven',
  12: 'twelve',
  13: 'thirteen',
  14: 'fourteen',
  15: 'fifteen',
  16: 'sixteen',
  17: 'seventeen',
  18: 'eighteen',
  19: 'nineteen',
  20: 'twenty',
  30: 'thirty',
  40: 'forty',
  50: 'fifty',
  60: 'sixty',
  70: 'seventy',
  80: 'eighty',
  90: 'ninety',
};

var units = [
  'hundred',
  'thousand',
  'million',
  'billion',
  'trillion',
  'quadrillion',
  'quintillion',
  'sextillion',
  'septillion',
  'octillion',
  'nonillion',
  'decillion',
  'undecillion',
  'duodecillion',
  'tredecillion',
  'quattuordecillion',
  'quindecillion',
];

var mults = units.map(function(x, i) {
  if(i === 0) return 100;
  else return Math.pow(1000, i);
});

function writtenNumber(n, noAnd) {
  if(n < 20) {
    return baseCardinals[n];
  }

  if(n < 100) {
    var dec = Math.floor(n / 10) * 10;
    var unit = n - dec;
    if(unit) {
      return baseCardinals[dec] + '-' + writtenNumber(unit);
    }
    return baseCardinals[dec];
  }

  var m = n % 100;
  var ret = [];
  if(m) {
    if(!noAnd) {
      ret.push('and ' + writtenNumber(m));
    } else ret.push(writtenNumber(m));
    n -= m;
  } else ret = [];

  for(var i = 0, len = units.length; i < len; i++) {
    var r = Math.floor(n / mults[i]);
    if(i === 0) {
      r %= 10;
    } else r %= 1000;

    if(r) {
      ret.push(writtenNumber(r, true) + ' ' + units[i]);
    }
  }
  return ret.reverse().join(' ');
}

console.log(writtenNumber(123));
console.log(writtenNumber(1230));

/*
The MIT License (MIT)

Copyright (c) 2015 Pedro Tacla Yamada

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
