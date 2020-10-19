import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:scan/router/Routes.dart';
import 'base/Application.dart';

void main() {
  //注册路由
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
  runApp(MyApp(),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      /// 生成路由
      onGenerateRoute: Application.router.generator,
      builder: (BuildContext context, Widget child) {
        /// 确保 loading 组件能覆盖在其他组件之上.
        return FlutterEasyLoading(child: child);
      },
    );
  }
}

