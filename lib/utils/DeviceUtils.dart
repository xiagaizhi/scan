import 'dart:io';
import 'package:device_info/device_info.dart';


class DeviceUtils {
  ///android 设备信息
  static AndroidDeviceInfo androidDeviceInfo;
  ///ios 设备信息
  static IosDeviceInfo iosDeviceInfo;

  static getDevices(){
    if(Platform.isIOS){
      //ios相关代码
    }else if(Platform.isAndroid){
      //android相关代码
    }
  }

  static void getDeviceInfo() async{
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    if(Platform.isIOS){
      iosDeviceInfo = await deviceInfo.iosInfo;
    }else if(Platform.isAndroid){
      androidDeviceInfo = await deviceInfo.androidInfo;
      print("devices:"+androidDeviceInfo.toString());
    }
  }
}
