import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DeviceDetail {
  String deviceId = '';
  String platform = '';
  String version = '';
  String machine = '';

  DeviceDetail({this.deviceId, this.platform, this.version, this.machine});
}


class AppStateProvider with ChangeNotifier {
  DeviceDetail _device = DeviceDetail(
    deviceId: '', platform: '', version: '', machine: ''
  );

  get device => _device;

  AppStateProvider(){
    getDeviceInfo();
  }

  getDeviceInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    DeviceDetail device;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      device = DeviceDetail(
        deviceId: androidInfo.display,
        machine: androidInfo.model,
        version: androidInfo.version.release,
        platform: 'Android',
      );

    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      device = DeviceDetail(
        deviceId: iosInfo.identifierForVendor,
        machine: iosInfo.utsname.machine,
        version: iosInfo.systemVersion,
        platform: 'iOS',
      );
    }

    pref.setString('deviceInfo', json.encode({
      'deviceId': device.deviceId,
      'machine': device.machine,
      'version': device.version,
      'platform': device.platform
    }));

    _device = device;
    notifyListeners();
  }

}