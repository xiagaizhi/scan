import 'ienv.dart';

class Prod implements IEnv {
  @override
  Map<UrlType, String> map = {
    UrlType.normal: "//mall.ygxy.com",
    UrlType.ocr: "//ocr.ygxy.com",
    UrlType.food: '//food-traceability.gzygxy.com',
    UrlType.edu: "//edu.gzygxy.com/edu",
    UrlType.extEdu: '//eduext.gzygxy.com',
    UrlType.meal: "//meal.gzygxy.com",
    UrlType.mall: "//mall.ygxy.com",
    UrlType.order: "//order.gzygxy.com",
    UrlType.sso: "//sso.gzygxy.com",
    UrlType.iPass: '//ipass.gzygxy.com',
    UrlType.uc: "//uc.gzygxy.com",
    UrlType.wo: "//wo.gzygxy.com",
    UrlType.tMeal: "//tmeal.gzygxy.com",
    UrlType.pay: "//pay.gzygxy.com",
    UrlType.statement: '//statement.gzygxy.com',
    UrlType.im: "//im.gzygxy.com",
    UrlType.swan: "//swan.gzygxy.com",
    UrlType.epidemic: '//centipede.gzygxy.com',
    UrlType.oss: "//oss.gzygxy.com",
    UrlType.ossRoot: "http://ygxy-app.oss-cn-shenzhen.aliyuncs.com/",
    UrlType.schoolApp: '//school.gzygxy.com/',
    UrlType.h5App: '../../',
    UrlType.http: 'http:',
    UrlType.logistics: "//logistics.gzygxy.com/"
  };

  @override
  String getUrl(UrlType type) {
    return map[UrlType.http] + map[type];
  }
}
