

import 'package:scan/constants/pre.dart';
import 'package:scan/constants/prod.dart';
import 'package:scan/constants/qa.dart';

import 'dev.dart';
import 'ienv.dart';

class Config {
  static Env _env = Env.QA;

  static String conStr = 'DEV';

  static IEnv getEnv() {
    switch (conStr) {
      case 'Dev':
        return Dev();
      case 'QA':
        return Qa();
        break;
      case 'PRE':
        return Pre();
        break;
      case 'PROD':
        return Prod();
        break;
    }
    return Dev();
  }

  static String getBaseUrl(UrlType type) {
    return getEnv().getUrl(type);
  }
}

enum Env {
  DEV,
  QA,
  PRE,
  PROD,
}
