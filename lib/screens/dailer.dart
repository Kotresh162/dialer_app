import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dailer/controller/DialerController.dart';
import 'package:dailer/screens/dailpad.dart';

class DialerScreen extends StatelessWidget {
  final DialerController controller = Get.put(DialerController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss keyboard when tapping outside
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            onChanged: (value) => controller.searchQuery.value = value, // Updates search query
            decoration: InputDecoration(
              hintText: 'Search...',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.grey),
            ),
          ),
          actions: [
            IconButton(icon: Icon(Icons.mic), onPressed: () {}),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
        body: Column(
          children: [
            Padding(padding: const EdgeInsets.all(8.0)),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.filteredCalls.length,
                    itemBuilder: (context, index) {
                      final recentCall = controller.filteredCalls[index];

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          child: Icon(Icons.person, color: Colors.white), // Caller icon
                        ),
                        title: Text(recentCall), // Caller name or number
                        trailing: Icon(Icons.call_made, color: Colors.green), // Outgoing call icon
                        onTap: () async {
                          final Uri url = Uri(scheme: 'tel', path: recentCall);
                          if (await launchUrl(url)) {
                            controller.moveCallToTop(recentCall); // Move call to top of list
                          } else {
                            print("Cannot launch dialer");
                          }
                        },
                      );
                    },
                  )),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.dialpad),
          onPressed: () {
            Get.dialog(DialerPad());
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
