
import 'package:scan/network/dev.dart';

import 'ienv.dart';

class Config {
  static Env _env = Env.DEV;

  static IEnv getEnv() {
    switch (_env) {
      case Env.DEV:
        return Dev();
      case Env.QA:
        break;
      case Env.PRE:
        break;
      case Env.PROD:
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
