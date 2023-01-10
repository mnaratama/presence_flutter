import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: emailC.text, password: passC.text);

        print("ini user $userCredential");

        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            if(passC.text == "password"){
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
                title: "Belum Verifikasi",
                middleText:
                    "Kamu belum verifikasi akun ini. Lakukan verifikasi diemail kamu",
                actions: [
                  OutlinedButton(
                      onPressed: (){
                        Get.back();
                      }, child: Text("CANCEL")),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          await userCredential.user!.sendEmailVerification();
                          Get.back();
                          Get.snackbar("Berhasil",
                              "Kami telah berhasil mengirim email verifikasi ke akun kamu.");
                        } catch (e) {
                          Get.snackbar("Terjadi Kesalahan",
                              "Tidak dapat mengirim email verifikasi. Hubungi admin.");
                        }
                      },
                      child: Text("KIRIM ULANG"))
                ]);
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar("Terjadi Kesalahan", "Email tidak terdaftar.");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Terjadi Kesalahan", "Password salah.");
        }
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan", "Tidak dapat login.");
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Terjadi Kesalahan", "Email dan password wajib diisi.");
    }
  }
}
