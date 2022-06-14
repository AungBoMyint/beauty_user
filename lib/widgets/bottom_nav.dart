import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(7),
          topRight: Radius.circular(7),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, -0.05),
          )
        ],
      ),
      child: Obx(
        () => Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      controller.changeNav(0);
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.home,
                      color: controller.navIndex.value == 0
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                  Text("Home"),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                     controller.changeNav(1);
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.shoppingBag,
                      color: 
                           Colors.grey,
                    ),
                  ),
                  Text("Shop"),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      controller.changeNav(2);
                    },
                    icon: Stack(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.tag,
                          color: controller.navIndex.value == 2
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  Text("Offers"),
                ],
              ),
            ),
            // Expanded(
            //   child: Column(
            //     children: [
            //       IconButton(
            //         onPressed: () {
            //           controller.changeNav(2);
            //         },
            //         icon: Stack(
            //           children: [
            //             FaIcon(
            //               FontAwesomeIcons.shoppingCart,
            //               color: controller.navIndex.value == 2
            //                   ? Colors.black
            //                   : Colors.grey,
            //             ),
            //             CircleAvatar(
            //                 backgroundColor: Colors.orange,
            //                 minRadius: 0,
            //                 maxRadius: 10,
            //                 child: Text(
            //                   controller.myCart.length.toString(),
            //                   style:
            //                       TextStyle(color: Colors.white, fontSize: 14),
            //                 )),
            //           ],
            //         ),
            //       ),
            //       Text("Cart"),
            //     ],
            //   ),
            // ),
            // Expanded(
            //   child: Column(
            //     children: [
            //       IconButton(
            //         onPressed: () {
            //           controller.changeNav(3);
            //         },
            //         icon: Icon(
            //           FontAwesomeIcons.solidHeart,
            //           color: controller.navIndex.value == 3
            //               ? Colors.black
            //               : Colors.grey,
            //         ),
            //       ),
            //       Text("Favourite"),
            //     ],
            //   ),
            // ),
            Expanded(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      controller.changeNav(3);
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.user,
                      color: controller.navIndex.value == 3
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                  Text("Me"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
