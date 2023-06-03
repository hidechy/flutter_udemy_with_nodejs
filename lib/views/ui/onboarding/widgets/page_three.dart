import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/app_constants.dart';
import '../../../common/app_style.dart';
import '../../../common/custom_outline_btn.dart';
import '../../../common/height_spacer.dart';
import '../../../common/reusable_text.dart';
import '../../auth/login.dart';
import '../../auth/signup.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color(kLight.value),
        child: Column(
          children: [
            Image.asset('assets/images/page3.png'),
            const HeightSpacer(size: 20),
            ReusableText(
              text: 'Welcome To JobHub',
              style: appstyle(
                30,
                Color(kLight.value),
                FontWeight.w600,
              ),
            ),
            const HeightSpacer(size: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'We help you find your dream job to your skillset, location and preference to build your career',
                textAlign: TextAlign.center,
                style: appstyle(14, Color(kLight.value), FontWeight.normal),
              ),
            ),
            const HeightSpacer(size: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomOutlineBtn(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();

                    await prefs.setBool('entrypoint', true);

                    await Get.to(() => const LoginPage());
                  },
                  text: 'Login',
                  width: width * 0.4,
                  height: height * 0.06,
                  color: Color(kLight.value),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const RegistrationPage());
                  },
                  child: Container(
                    width: width * 0.4,
                    height: height * 0.06,
                    color: Color(kLight.value),
                    child: Center(
                      child: ReusableText(
                        text: 'Sign Up',
                        style: appstyle(
                          16,
                          Color(kLightBlue.value),
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const HeightSpacer(size: 30),
          ],
        ),
      ),
    );
  }
}
