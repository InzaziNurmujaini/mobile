//import 'package:baruu/app/modules/deskripsi/views/deskripsi_view.dart';
//import 'package:baruu/app/modules/login/views/login_view.dart';
//import 'package:codelab3/app/modules/login/views/login_view.dart';
import 'package:codelab3/app/modules/signup/views/signup_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/getstarted_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class GetstartedView extends GetView<GetstartedController> {
  const GetstartedView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8B595),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Image.asset("assets/logo.png"),
                  Text(
                    'KUBU BARAT CAMP OUTDOOR ACTIVITY',
                    style: GoogleFonts.itim(
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                      width: 180,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to( SignupPage());
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ))
                ],
              )
            ]),
      ),
    );
  }
}
