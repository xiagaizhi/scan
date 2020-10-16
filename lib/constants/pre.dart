import 'ienv.dart';

class Pre implements IEnv {
  @override
  Map<UrlType, String> map = {
    UrlType.normal: "//mall-pre.ygxy.com",
    UrlType.ocr: "//ocr-pre.ygxy.com",
    UrlType.food: '//food-traceability-pre.gzygxy.com',
    UrlType.edu: "//edu-pre.gzygxy.com/edu",
    UrlType.extEdu: '//eduext-pre.gzygxy.com',
    UrlType.meal: "//meal-pre.gzygxy.com",
    UrlType.mall: "//mall-pre.ygxy.com",
    UrlType.order: "//order-pre.gzygxy.com",
    UrlType.sso: "//sso-pre.gzygxy.com",
    UrlType.iPass: '//ipass-pre.gzygxy.com',
    UrlType.uc: "//uc-pre.gzygxy.com",
    UrlType.wo: "//wo-pre.gzygxy.com",
    UrlType.tMeal: "//tmeal-pre.gzygxy.com",
    UrlType.pay: "//pay-pre.gzygxy.com",
    UrlType.statement: '//statement-pre.gzygxy.com',
    UrlType.im: "//im-pre.gzygxy.com",
    UrlType.swan: "//swan-pre.gzygxy.com",
    UrlType.epidemic: '//centipede-pre.gzygxy.com',
    UrlType.oss: "//oss-pre.gzygxy.com",
    UrlType.ossRoot: "http://ygxy-app.oss-cn-shenzhen.aliyuncs.com/",
    UrlType.schoolApp: '//school-pre.gzygxy.com/',
    UrlType.h5App: '../../',
    UrlType.http: 'http:',
    UrlType.logistics: "//logistics-pre.gzygxy.com/"
  };

  @override
  String getUrl(UrlType type) {
    return map[UrlType.http] + map[type];
  }
}
