import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/routes/routes.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/utils.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Obx(
      () => !(controller.currentUser.value == null)
          ? _LoginUser()
          : LoginScreen(),
    );
  }
}

class _LoginUser extends StatelessWidget {
  const _LoginUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController _homeController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 2,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Beauty",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: appBarTitleColor,
            letterSpacing: 2,
            wordSpacing: 2,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(
              height: 40,
            ),
            //User Profile Image
            Obx(() {
              return CachedNetworkImage(
                imageBuilder: (context, imageProvider) {
                  return CircleAvatar(
                    radius: 40,
                    backgroundImage: imageProvider,
                  );
                },
                progressIndicatorBuilder: (context, url, status) {
                  return Shimmer.fromColors(
                    child: Container(
                      color: Colors.white,
                    ),
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                  );
                },
                errorWidget: (context, url, whatever) {
                  return const Text("Image not available");
                },
                imageUrl: _homeController.currentUser.value?.image ?? userImage,
                //fit: BoxFit.fill,
              );
            }),

            const SizedBox(height: 5),
            //Point
            Container(
              height: 50,
              decoration: BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Point Text
                  Obx(() {
                    return Text(
                      "${_homeController.currentUser.value?.points}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: homeIndicatorColor,
                      ),
                    );
                  }),
                  const SizedBox(width: 10),
                  //Icon
                  Icon(
                    FontAwesomeIcons.coins,
                    color: homeIndicatorColor,
                    size: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            //User Name
            Obx(() {
              return Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text("Name   :",
                      style: TextStyle(fontSize: 20,
                        letterSpacing: 2,
                        wordSpacing: 2,
                    
                      ),),
                    ),
                    Expanded(
                      child: Text(
                        _homeController.currentUser.value?.userName.toUpperCase() ?? "",
                        style: textStyleBold.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 5),
            //User Email
            Obx(() {
              return Padding(
                padding: const EdgeInsets.only(left: 40, right: 40,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text("Email   :",
                                      style: TextStyle(fontSize: 20,
                      letterSpacing: 2,
                      wordSpacing: 2,
                      ),),
                    ),
                    Expanded(
                      child: Text(
                        _homeController.currentUser.value?.emailAddress ?? "",
                        style: textStyleBold.copyWith(
                          fontSize: 18,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () {
                    _homeController.logOut();
                  },
                  child: Text("Log Out",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 2,
                        wordSpacing: 2,
                        color: Colors.white,
                      ))),
            ),
            //Delete
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () {
                    _homeController.deleteAccount();
                  },
                  child: Text("Delete Account",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 2,
                        wordSpacing: 2,
                        color: Colors.white,
                      ))),
            ),
          ]),
        ),
      ),
    );
  }
}



class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              color: Colors.transparent,
              constraints: BoxConstraints(
                maxWidth: 400.0,
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: Image.asset(
                      "assets/logo.png",
                      width: Get.width / 3,
                    ),
                  ),
                  /*Text(
                    "Pos App",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),*/
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    width: Get.width - 100,
                    child: InkWell(
                      onTap: () => homeController.signInWithGoogle(),
                      child: Card(
                        color: homeIndicatorColor,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: homeIndicatorColor,
                                radius: 12,
                                child: Icon(
                                  FontAwesomeIcons.google,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "Sign in with Google",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
