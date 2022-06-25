import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:track_flotilla/providers/dashboard_provider.dart';
import 'package:track_flotilla/screens/geoFence/geoFence_list_page.dart';
import 'package:track_flotilla/screens/staff/group_list_page.dart';
import 'package:track_flotilla/screens/staff/staff_list_page.dart';
import 'package:track_flotilla/screens/widgets/custom_list_tile.dart';
import 'package:track_flotilla/screens/widgets/customAppBar.dart';
import 'package:track_flotilla/screens/widgets/my_text.dart';
import 'package:track_flotilla/shared_pref/shared_pref.dart';
import 'package:track_flotilla/utils/appColor.dart';
import 'package:track_flotilla/utils/app_size.dart';
import 'package:track_flotilla/utils/responsive.dart';
import 'package:track_flotilla/utils/shahdow.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'monitoring_list_page.dart';

class Monitoring extends StatefulWidget {
  Monitoring({Key? key}) : super(key: key);

  @override
  State<Monitoring> createState() => _MonitoringState();
}

class _MonitoringState extends State<Monitoring> {
  late DashboardProvider dashboardProvider;

  @override
  void initState() {
    super.initState();
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: customAppBar(context, "Monitoring"),
          body: Column(
            children: [
              Container(
                width: 500.w,
                height: 85.h,
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Ubuntu",
                    fontSize: 24.sp,
                  ),
                  indicator: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(10.r), // Creates border
                      gradient: AppColors.primarygradient),
                  tabs: [
                    Tab(
                      text: "Monitoring",
                    ),
                    Tab(
                      text: "Group",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Flexible(
                child: Container(
                  // color: Colors.amber,
                  child: TabBarView(
                    children: [
                      MonitoringListPage(),
                      GroupListPage(),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
// 