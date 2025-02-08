import 'package:get/get.dart';

class DialerController extends GetxController {
  var phoneNumber = ''.obs;

  void addDigit(String digit) {
    if (phoneNumber.value.length < 10) {
      phoneNumber.value += digit;
    }
  }

  void deleteDigit() {
    if (phoneNumber.isNotEmpty) {
      phoneNumber.value = phoneNumber.substring(0, phoneNumber.value.length - 1);
    }
  }

  void makeCall() {
    // Implement call functionality (use url_launcher for real calls)
    print("Calling: ${phoneNumber.value}");
  }
}
