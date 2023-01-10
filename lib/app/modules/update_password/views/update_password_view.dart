import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UPDATE PASSWORD'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            obscureText: true,
            controller: controller.currC,
            decoration: InputDecoration(
                labelText: "Current Password", border: OutlineInputBorder()),
          ),
          SizedBox(height: 10),
          TextField(
            autocorrect: false,
            obscureText: true,
            controller: controller.newC,
            decoration: InputDecoration(
                labelText: "New Password", border: OutlineInputBorder()),
          ),
          SizedBox(height: 10),
          TextField(
            autocorrect: false,
            obscureText: true,
            controller: controller.confirmC,
            decoration: InputDecoration(
                labelText: "Confirm New Password", border: OutlineInputBorder()),
          ),
          SizedBox(height: 10),
          Obx(() => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  controller.updatePass();
                }
              },
              child: Text(controller.isLoading.isFalse
                  ? "CHANGE PASSWORD"
                  : "LOADING...")))
        ],
      ),
    );
  }
}
