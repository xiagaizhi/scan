import 'ienv.dart';

class Dev implements IEnv {
  @override
  Map<UrlType, String> map = {
    UrlType.normal: "//mall.dev-ag.ygxy.com",
    UrlType.ocr: "//ocr.dev-ag.ygxy.com",
    UrlType.food: '//food-traceability.dev-ag.gzygxy.com',
    UrlType.edu: "//edu.dev-ag.gzygxy.com/edu",
    UrlType.extEdu: '//eduext.dev-ag.gzygxy.com',
    UrlType.meal: "//meal.dev-ag.gzygxy.com",
    UrlType.mall: "//mall.dev-ag.ygxy.com",
    UrlType.order: "//order.dev-ag.gzygxy.com",
    UrlType.sso: "//sso.dev-ag.gzygxy.com",
//    UrlType.sso: "//192.168.66.66",
    UrlType.iPass: '//ipass.dev-ag.gzygxy.com',
    UrlType.uc: "//uc.dev-ag.gzygxy.com",
    UrlType.wo: "//wo.dev-ag.gzygxy.com",
    UrlType.tMeal: "//tmeal.dev-ag.gzygxy.com",
    UrlType.pay: "//pay.dev-ag.gzygxy.com",
    UrlType.statement: '//statement.dev-ag.gzygxy.com',
    UrlType.im: "//im.dev-ag.gzygxy.com",
    UrlType.swan: "//swan.dev-ag.gzygxy.com",
    UrlType.epidemic: '//centipede.dev-ag.gzygxy.com',
    UrlType.oss: "//oss.dev-ag.gzygxy.com",
    UrlType.ossRoot: "http://ygxy-app.oss-cn-shenzhen.aliyuncs.com/",
    UrlType.schoolApp: '//school.dev-ag.gzygxy.com/',
    UrlType.h5App: '../../',
    UrlType.http: 'http:',
    UrlType.logistics: "//logistics.dev-ag.gzygxy.com"
  };

  @override
  String getUrl(UrlType type) {
    return map[UrlType.http] + map[type];
  }
}
