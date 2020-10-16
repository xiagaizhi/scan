import 'ienv.dart';

class Qa implements IEnv {
  @override
  Map<UrlType, String> map = {
    UrlType.normal: "//mall.qa-ag.ygxy.com",
    UrlType.ocr: "//ocr.qa-ag.ygxy.com",
    UrlType.food: '//food-traceability.qa-ag.gzygxy.com',
    UrlType.edu: "//edu.qa-ag.gzygxy.com/edu",
    UrlType.extEdu: '//eduext.qa-ag.gzygxy.com',
    UrlType.meal: "//meal.qa-ag.gzygxy.com",
    UrlType.mall: "//mall.qa-ag.ygxy.com",
    UrlType.order: "//order.qa-ag.gzygxy.com",
    UrlType.sso: "//sso.qa-ag.gzygxy.com",
    UrlType.iPass: '//ipass.qa-ag.gzygxy.com',
    UrlType.uc: "//uc.qa-ag.gzygxy.com",
    UrlType.wo: "//wo.qa-ag.gzygxy.com",
    UrlType.tMeal: "//tmeal.qa-ag.gzygxy.com",
    UrlType.pay: "//pay.qa-ag.gzygxy.com",
    UrlType.statement: '//statement.qa-ag.gzygxy.com',
    UrlType.im: "//im.qa-ag.gzygxy.com",
    UrlType.swan: "//swan.qa-ag.gzygxy.com",
    UrlType.epidemic: '//centipede.dqa-ag.gzygxy.com',
    UrlType.oss: "//oss.qa-ag.gzygxy.com",
    UrlType.ossRoot: "http://ygxy-app.oss-cn-shenzhen.aliyuncs.com/",
    UrlType.schoolApp: '//school.qa-ag.gzygxy.com/',
    UrlType.h5App: '../../',
    UrlType.http: 'http:',
    UrlType.logistics: "//logistics.qa-ag.gzygxy.com/"
  };

  @override
  String getUrl(UrlType type) {
    return map[UrlType.http] + map[type];
  }
}
