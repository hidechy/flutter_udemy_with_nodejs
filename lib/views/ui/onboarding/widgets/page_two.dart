import 'package:flutter/material.dart';

import '../../../../constants/app_constants.dart';
import '../../../common/app_style.dart';
import '../../../common/height_spacer.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color(kDarkBlue.value),
        child: Column(
          children: [
            const HeightSpacer(size: 65),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset('assets/images/page2.png'),
            ),
            const HeightSpacer(size: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Stable Yourself \n With Your Ability',
                  textAlign: TextAlign.center,
                  style: appstyle(30, Color(kLight.value), FontWeight.w500),
                ),
                const HeightSpacer(size: 10),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'We help you find your dream job according to your skillset, location and preference to build your career',
                    textAlign: TextAlign.center,
                    style: appstyle(14, Color(kLight.value), FontWeight.normal),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
