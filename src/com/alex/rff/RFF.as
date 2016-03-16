package com.alex.rff {
  import flash.utils.ByteArray;

  public class RFF {
    static public const VER = '0.0.1';
    static public const MARK_STR = 'RHINO';
    static private const MARK_STR_LEN = MARK_STR.length;
    static private const ALG_MAP = [];

    static public function isRFF(input:ByteArray) {
        if(!input || input.bytesAvailable < MARK_STR_LEN) return false;

        var curPos = input.position;
        var result =  input.readUTFBytes(MARK_STR_LEN) === MARK_STR;
        input.position = curPos;
        return result;
    }

    static public function registAlgorithm(algNum, algCls) {
        ALG_MAP[algNum] = algCls;
    }

    static public function decode(input:ByteArray, output:ByteArray) {
      var curPos = bytes.position;
      input.position += (MARK_STR_LEN + 2);//and v len (2B)

      var algNum = input.readUnsignedShort();
      var algInst = null;
      if(algNum === 0) {
        algCls = new NullAlgorithm();
      } else {
        algCls = new ALG_MAP[algNum]();
      }

      algInst.decode();
    }

    static public function decodeAsync(input:ByteArray, output:ByteArray, callback:function) {
      var curPos = bytes.position;
      input.position += (MARK_STR_LEN + 2);//and v len (2B)

      var algNum = input.readUnsignedShort();
      var algInst = null;
      if(algNum === 0) {
        algCls = new NullAlgorithm();
      } else {
        algCls = new ALG_MAP[algNum]();
      }

      algInst.decodeAsync(input, output, callback);
    }
  }
}

//--

import flash.utils.ByteArray;

class NullAlgorithm {
  public function decode(input:ByteArray, output:ByteArray) {
    var bodyLen = input.readUnsignedInt();
    input.readBytes(output, 0, bodyLen);
  }

  public function decodeAsync(input:ByteArray, output:ByteArray, callback) {
    decode(input, output);
    callback();
  }
}