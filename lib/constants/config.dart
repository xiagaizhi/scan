

import 'package:scan/constants/pre.dart';
import 'package:scan/constants/prod.dart';
import 'package:scan/constants/qa.dart';

import 'dev.dart';
import 'ienv.dart';

class Config {
  static Env _env = Env.QA;

  static IEnv getEnv() {
    switch (_env) {
      case Env.DEV:
        return Dev();
      case Env.QA:
        return Qa();
        break;
      case Env.PRE:
        return Pre();
        break;
      case Env.PROD:
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
