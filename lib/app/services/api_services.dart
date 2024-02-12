import 'package:flutter/material.dart';

class ApiServices {
  static String _url = "192.168.100.16:8000";
  static const int _port = 8000;

  static TextEditingController ipAddressController =
      TextEditingController(text: _url);

  static String get baseUrl => "http://$_url/api";
  static String get baseUrlImage => "http://$_url/users/";

  static void changeIpAddress(String newIpAddress) {
    _url = newIpAddress;
  }
}
