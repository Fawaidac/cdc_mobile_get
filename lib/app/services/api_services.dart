import 'package:flutter/material.dart';

class ApiServices {
  static String _ipAddress = "192.168.0.117";
  static const int _port = 8000;

  static TextEditingController ipAddressController =
      TextEditingController(text: _ipAddress);

  static String get baseUrl => "http://$_ipAddress:$_port/api";
  static String get baseUrlImage => "http://$_ipAddress:$_port/users/";

  static void changeIpAddress(String newIpAddress) {
    _ipAddress = newIpAddress;
  }
}
