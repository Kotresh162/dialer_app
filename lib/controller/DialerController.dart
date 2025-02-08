import 'package:get/get.dart';

class DialerController extends GetxController {
  var phoneNumber = ''.obs;
  var recentCalls = <String>[].obs;
  var searchQuery = ''.obs; // New search query variable

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
    if (phoneNumber.isNotEmpty) {
      String callEntry = "${phoneNumber.value}";
      if (!recentCalls.contains(callEntry)) {
        recentCalls.insert(0, callEntry); // Add to call history
      }
      phoneNumber.value = ''; // Reset after call
    }
  }

  void moveCallToTop(String recentCall) {
  filteredCalls.remove(recentCall); // Remove it from the list
  filteredCalls.insert(0, recentCall); // Add it at the top
  }

  List<String> get filteredCalls {
    if (searchQuery.isEmpty) {
      return recentCalls;
    }
    return recentCalls
        .where((call) => call.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }
}
