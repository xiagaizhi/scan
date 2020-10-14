import 'dart:math';

class CommonUtil {
  static randomBit(int len) {
    String scopeF = "123456789";
    String scopeC = "0123456789";
    String result = "";
    for (int i = 0; i < len; i++) {
      if (i == 1) {
        result = scopeF[Random().nextInt(scopeF.length)];
      } else {
        result = result + scopeC[Random().nextInt(scopeC.length)];
      }
    }
    var t=int.parse(result);
    return t;
  }
}
