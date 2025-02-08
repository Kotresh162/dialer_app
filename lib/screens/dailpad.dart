import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dailer/controller/DialerController.dart';

class DialerPad extends StatelessWidget {
  final DialerController controller = Get.put(DialerController());

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.50, // Covers 60-70% of screen
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Center(
                        child: Obx(() => Text(
                              controller.phoneNumber.value,
                              style: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.backspace, size: 30),
                    onPressed: controller.deleteDigit,
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  List<String> buttons = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "0", "#"];
                  return ElevatedButton(
                    onPressed: () => controller.addDigit(buttons[index]),
                    child: Text(
                      buttons[index],
                      style: const TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  );
                },
              ),
            ),
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
              child: const Icon(Icons.call, size: 40),
              backgroundColor: Colors.green,

            ),
          ],
        ),
      ),
    );
  }
}