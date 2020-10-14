import 'dart:io';
import 'package:device_info/device_info.dart';


class DeviceUtils {


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
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    }else if(Platform.isAndroid){
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      print("devices:"+androidDeviceInfo.toString());
    }
  }
}
