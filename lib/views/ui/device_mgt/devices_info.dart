import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/providers/login_provider.dart';
import '../../../controllers/providers/onboarding_provider.dart';
import '../../../controllers/providers/zoom_provider.dart';
import '../../common/app_bar.dart';
import '../../common/app_style.dart';
import '../../common/drawer/drawer_widget.dart';
import '../../common/height_spacer.dart';
import '../../common/reusable_text.dart';
import 'widgets/device_info.dart';

class DeviceManagement extends StatelessWidget {
  const DeviceManagement({super.key});

  @override
  Widget build(BuildContext context) {
    final zoomNotifier = Provider.of<ZoomNotifier>(context);

    final onBoarding = Provider.of<OnBoardNotifier>(context);

    final date = DateTime.now().toString();

    final loginDate = date.substring(0, 11);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: 'Device Management',
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpacer(size: 50),
                  Text(
                    'You are logged in into your account on these devices',
                    style: appstyle(16, Color(kDark.value), FontWeight.normal),
                  ),
                  const HeightSpacer(size: 50),
                  DevicesInfo(
                    date: loginDate,
                    device: 'MacBook M2',
                    ipAdress: '10.0.12.000',
                    location: 'Washington DC',
                    platform: 'Apple Webkit',
                  ),
                  const HeightSpacer(size: 50),
                  DevicesInfo(
                    date: loginDate,
                    device: 'iPhone 14',
                    ipAdress: '10.0.12.000',
                    location: 'Brooklyn',
                    platform: 'Mobile App',
                  )
                ],
              ),
            ),
            Consumer<LoginNotifier>(
              builder: (context, loginNotifier, child) {
                return Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: GestureDetector(
                    onTap: () {
                      zoomNotifier.currentIndex = 0;
                      loginNotifier.logout();
                      onBoarding.isLastPage = false;

                      //
                      //
                      // Get.to(() => defaultHome);
                      //
                      //
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ReusableText(
                          text: 'Sign out from all devices',
                          style: appstyle(
                              16, Color(kOrange.value), FontWeight.w600)),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
