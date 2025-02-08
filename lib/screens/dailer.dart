import 'package:dailer/controller/DialerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart'; // For making phone calls

class DialerScreen extends StatelessWidget {
  final DialerController controller = Get.put(DialerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dialer")),
      body: Column(
        children: [
          // Display Phone Number
          Expanded(
            child: Center(
              child: Obx(() => Text(
                    controller.phoneNumber.value,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  )),
            ),
          ),
          
          // Dial Pad
          GridView.builder(
            shrinkWrap: true,
            itemCount: 12,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              List<String> buttons = [
                "1", "2", "3",
                "4", "5", "6",
                "7", "8", "9",
                "*", "0", "#"
              ];
              return ElevatedButton(
                onPressed: () => controller.addDigit(buttons[index]),
                child: Text(
                  buttons[index],
                  style: TextStyle(fontSize: 24),
                ),
              );
            },
          ),

          // Call & Delete Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Delete Button
                IconButton(
                  icon: Icon(Icons.backspace, size: 30),
                  onPressed: controller.deleteDigit,
                ),
                
                // Call Button
                FloatingActionButton(
                  onPressed: () async {
                    final number = controller.phoneNumber.value;
                    if (number.isNotEmpty) {
                      final url = "tel:$number";
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        print("Cannot launch dialer");
                      }
                    }
                  },
                  child: Icon(Icons.call),
                  backgroundColor: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
