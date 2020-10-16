abstract class IEnv {
  Map<UrlType, String> map = new Map();

  String getUrl(UrlType type);
}

enum UrlType {
  normal,
  ocr,
  food,
  edu,
  extEdu,
  meal,
  mall,
  order,
  sso,
  iPass,
  uc,
  wo,
  tMeal,
  pay,
  statement,
  im,
  swan,
  epidemic,
  oss,
  ossRoot,
  schoolApp,
  h5App,
  http,
  logistics
}
