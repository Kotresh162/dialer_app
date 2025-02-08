import 'package:dailer/screens/dailpad.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart'; // For making phone calls
import 'package:dailer/controller/DialerController.dart';

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
            decoration: InputDecoration(
              hintText: 'Search...',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.grey), // Search icon inside TextField
            ),
          ),
          actions: [
            IconButton(icon: Icon(Icons.mic), onPressed: () {}),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),

        body: Column(
          children: [
            
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => ListTile(
                  leading: Icon(Icons.phone),
                  title: Text("Contact ${index + 1}"),
                  subtitle: Text("+91 98765 4321${index}"),
                  trailing: IconButton(
                    icon: Icon(Icons.call),
                    onPressed: () {
                      launchUrl(Uri(scheme: 'tel', path: "+91 98765 4321${index}"));
                    },
                  ),
                ),
              ),
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
