import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/expaned_widget.dart';
import 'package:kozarni_ecome/model/hive_item.dart';
import 'package:kozarni_ecome/routes/routes.dart';
import 'home_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final currentProduct = controller.editItem.value;
    return Scaffold(
      backgroundColor: detailTextBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          currentProduct!.name,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: ListView(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Hero(
                tag: currentProduct.photo1,
                child: CarouselSlider(
                  items: [
                    CachedNetworkImage(
                      imageUrl: currentProduct.photo1,
                      // "$baseUrl$itemUrl${currentProduct.photo}/get",
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    CachedNetworkImage(
                      imageUrl: currentProduct.photo2,
                      // "$baseUrl$itemUrl${currentProduct.photo}/get",
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    CachedNetworkImage(
                      imageUrl: currentProduct.photo3,
                      // "$baseUrl$itemUrl${currentProduct.photo}/get",
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ],
                  options: CarouselOptions(
                    height: 400,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ),
            margin: EdgeInsets.only(top: 10),
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: detailTextBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Star
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            size: 20,
                            color: index <= (currentProduct.love ?? 0)
                                ? homeIndicatorColor
                                : Colors.grey,
                          ),
                        ),
                      ),
                      //Favourite Icon
                      ValueListenableBuilder(
                        valueListenable:
                            Hive.box<HiveItem>(boxName).listenable(),
                        builder: (context, Box<HiveItem> box, widget) {
                          final currentObj =
                              box.get(currentProduct.id);

                          if (!(currentObj == null)) {
                            return IconButton(
                                onPressed: () {
                                  box.delete(currentObj.id);
                                },
                                icon: Icon(
                                  FontAwesomeIcons.solidHeart,
                                  color: Colors.red,
                                  size: 25,
                                ));
                          }
                          return IconButton(
                              onPressed: () {
                                box.put(
                                    currentProduct.id,
                                    controller.changeHiveItem(
                                        currentProduct));
                              },
                              icon: Icon(
                                Icons.favorite_outline,
                                color: Colors.red,
                                size: 25,
                              ));
                        },
                      ),
                    ]),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "တစ်ထည်ဈေး (Retail) :",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      "${currentProduct.price} Kyats",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Brand",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      "Delevery Time",
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      (currentProduct.discountPrice ?? 0) > 0 ?
                      "${currentProduct.discountPrice} Kyats" : "no discount price",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ExpandedWidget(
                  text: currentProduct.description,
                ),
                SizedBox(
                  height: 30,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "⏰ Delivery Time",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Within 3 Days",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "💁 Availability ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "In Stock",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "📞 Contact Phone ",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "     09 7777 0 222 8",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: currentProduct.photo2,
                          width: 150,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: currentProduct.photo3,
                                width: 150,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "🏠 Shop - 1  ( Thanlyin )",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'အမှတ် 116 ၊ သတိပဌာန်လမ်း ၊ မြို့မတောင်ရပ်ကွက် ၊ သန်လျင်မြို့နယ် ၊ ရန်ကုန်မြို့။',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "🏠 Shop - 2  ( Dawbon )",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'အမှတ် 192 ၊ ယမုံနာလမ်း ၊ ဇေယျာသီရိရပ်ကွက်, ဒေါပုံမြို့နယ် ။ (မာန်ပြေကားဂိတ်နားမရောက်ခင်...ဇေယျာသီရိ ၈ လမ်းထိပ်)',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 65,
        // decoration: BoxDecoration(
        //   color: detailBackgroundColor,
        //   borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(20),
        //     topRight: Radius.circular(20),
        //   ),
        // ),
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: ElevatedButton(
          style: buttonStyle,
          onPressed: () {
            if((currentProduct.color == null) && (currentProduct.size == null)){
              //------Add to Cart-------//
              controller.addToCart(currentProduct);
                Get.back();
            }else{
              Get.defaultDialog(
              titlePadding: EdgeInsets.all(0),
              contentPadding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              radius: 0,
              title: '',
              content: AddToCart(),
            );
            }
          },
          child: Text("၀ယ်ယူရန်"),
        ),
      ),
    );
  }
}

class AddToCart extends StatefulWidget {
  const AddToCart({
    Key? key,
  }) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  String? colorValue;
  String? sizeValue;
  final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final currentProduct = controller.editItem.value;
    return Column(
      children: [
        !(currentProduct?.color == null ) ?DropdownButtonFormField(
          value: colorValue,
          hint: Text(
            'Color',
            style: TextStyle(fontSize: 12),
          ),
          onChanged: (String? e) {
            colorValue = e;
          },
          items: currentProduct!.color!
              .split(',')
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: TextStyle(fontSize: 12),
                    ),
                  ))
              .toList(),
        ) : const SizedBox(),
        SizedBox(
          height: 10,
        ),
        !(currentProduct?.size == null) ? DropdownButtonFormField(
          value: sizeValue,
          hint: Text(
            "Size",
            style: TextStyle(fontSize: 12),
          ),
          onChanged: (String? e) {
            sizeValue = e;
          },
          items: currentProduct?.size
              !.split(',')
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: TextStyle(fontSize: 12),
                    ),
                  ))
              .toList(),
        ) : const SizedBox(),
        //Price Wholesale (or) Retail
        SizedBox(
          height: 10,
        ),
        
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              if (colorValue != null || 
                  sizeValue != null) {
                 controller.addToCart(currentProduct!,color: colorValue,size:sizeValue);
               Get.back();
               Get.back();
              }
            },
            child: Text("၀ယ်ယူရန်"),
          ),
        ),
      ],
    );
  }
}
