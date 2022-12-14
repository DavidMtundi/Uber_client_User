import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/OtherScreens/otherauthscreens/unauthpage.dart';
import 'package:taxiapp/OtherScreens/otherwidgets/walkthroughstepper.dart';
import 'package:taxiapp/OtherScreens/otherwidgets/walkthroughtemplate.dart';
import 'package:taxiapp/providers/user.dart';

class WalkThrough extends StatefulWidget {
  @override
  State<WalkThrough> createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {
  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  final PageController _pageViewController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final UserProvider _walkthroughProvider =
        Provider.of<UserProvider>(context);
    UserProvider.initialize();
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white70,
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView(
                  controller: _pageViewController,
                  onPageChanged: (int index) {
                    _walkthroughProvider.onPageChange(index);
                  },
                  children: <Widget>[
                    WalkThroughTemplate(
                      title: "Get instant rides",
                      subtitle:
                          "Book a ride with us for quality and customer friendly services.",
                      image: Image.asset("assets/images/walkthrough1.png"),
                    ),
                    WalkThroughTemplate(
                      title: "Get bonuses on each ride",
                      subtitle:
                          "Get bonusses and redemable points for the many rides you book with us.",
                      image: Image.asset("assets/images/walkthrough2.png"),
                    ),
                    WalkThroughTemplate(
                      title: "Get your delivery in time.",
                      subtitle: "Your trusted delivery person at all times.",
                      image: Image.asset("assets/images/walkthrough3.png"),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child:
                          WalkthroughStepper(controller: _pageViewController),
                    ),
                    ClipOval(
                      child: Container(
                        color: Theme.of(context).primaryColor,
                        child: IconButton(
                          icon: const Icon(
                            Icons.trending_flat,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (_pageViewController.page! >= 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contxt) => UnAuth()));
                              return;
                            }
                            _pageViewController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease);
                          },
                          padding: const EdgeInsets.all(13.0),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
