import 'package:get/get.dart';

class OtpController extends GetxController {
  var code = "";
  var fullname = "";
  var email = "";
  var pw = "";
  var phone = "";
  var alamat = "";
  var nik = "";
  var nim = "";
  var prodi = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var args = Get.arguments;
    fullname = args['fullname'];
    email = args['email'];
    pw = args['pw'];
    phone = args['phone'];
    alamat = args['alamat'];
    nik = args['nik'];
    nim = args['nim'];
    prodi = args['kode_prodi'];
  }
  
}
