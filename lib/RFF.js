'use strict';

const ALG_MAP = [];

export.isRFF = function() {
}

export.registAlgorithm = function(algNum, algCls) {
  ALG_MAP = algCls;
}

export.decode = function(input, output) {
}

export.decodeAsync(input, output, callback) {
}

function NullAlgorithm() {
}

NullAlgorithm.prototype.decode = function() {
}

NullAlgorithm.prototype.decodeAsync = function(input, output, callback) {
}