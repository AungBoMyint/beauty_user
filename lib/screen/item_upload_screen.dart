import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/controller/upload_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/widgets/home_category.dart';
import 'package:kozarni_ecome/widgets/status_button_list.dart';
import 'package:kozarni_ecome/widgets/tag_button_list.dart';

class UploadItem extends StatefulWidget {
  const UploadItem({Key? key}) : super(key: key);

  @override
  State<UploadItem> createState() => _UploadItemState();
}

class _UploadItemState extends State<UploadItem> {
  final UploadController controller = Get.find();
  final HomeController homecontroller = Get.find();
  
  @override
  void dispose() {
    homecontroller.setEditItem(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "DELUX BEAUTI",
          style: TextStyle(color: Colors.black, fontSize: 14)),
        actions: [
          // if (!(homecontroller.editItem.value == null)) ...[
          //   Padding(
          //     padding: const EdgeInsets.only(
          //       top: 12.0,
          //       bottom: 12.0,
          //     ),
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         primary: homeIndicatorColor,
          //       ),
          //       child: Text("Delete"),
          //       onPressed: () =>
          //           controller.delete(homecontroller.editItem.value!.id),
          //     ),
          //   ),
          // ],
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: homeIndicatorColor,
              ),
              child: Text("Save"),
              onPressed: () => controller.upload(),
            ),
          ),
        ],
        elevation: 5,
        backgroundColor: detailBackgroundColor,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back,
            color: appBarTitleColor,
          ),
        ),
      ),
      body: Form(
        key: controller.form,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 10,bottom: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Category:",
                ),
              ),
            ),
            // Category
            HomeCategory(),
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 10,bottom: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Status:",
                ),
              ),
            ),
            // Status
            StatusButtonList(),
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 10,bottom: 5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Tags:",
                ),
              ),
            ),
            //Tabs
            TagButtonList(),
                    //Photo1 
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                selectionControls: MaterialTextSelectionControls(),
                controller: controller.photo1Controller,
                validator: (value) => controller.validator(value: value,isOptional: false),
                decoration: InputDecoration(
                  hintText: 'Photo Link',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
           //Photo2
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                selectionControls: MaterialTextSelectionControls(),
                controller: controller.photo2Controller,
                validator: (value) => controller.validator(value: value,isOptional: false),
                decoration: InputDecoration(
                  hintText: 'Photo Link 2',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            //Photo3
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                selectionControls: MaterialTextSelectionControls(),
                controller: controller.photo3Controller,
                validator: (value) => controller.validator(value: value,isOptional: false),
                decoration: InputDecoration(
                  hintText: 'Photo Link 3',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
           //Name 
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                controller: controller.nameController,
                validator: (value) => controller.validator(value: value,isOptional: false),
                decoration: InputDecoration(
                  hintText: 'Product အမည်',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            //Description
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                // textInputAction: TextInputAction.done,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 1,
                maxLines: null,

                controller: controller.descriptionController,
                validator: (value) => controller.validator(value: value,isOptional: false),
                decoration: InputDecoration(
                  hintText: 'အသေးစိတ်ဖော်ပြချက်',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            //Price
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                controller: controller.priceController,
                validator: (value) => controller.validator(value: value,isOptional: false),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'ဈေးနှုန်း',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            //Discount
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                controller: controller.discountPriceController,
                validator: (value) => controller.validator(value: value,isOptional: true),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'အထူးလျော့ဈေး',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            //Color
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                controller: controller.colorController,
                validator: (value) => controller.validator(value: value,isOptional: true),
                decoration: InputDecoration(
                  hintText: 'အရောင်',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            //Size
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                controller: controller.sizeController,
                validator: (value) => controller.validator(value: value,isOptional: true),
                decoration: InputDecoration(
                  hintText: 'အရွယ်အစား',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            //Reward Point
             Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                controller: controller.requirePointController,
                validator: (value) => controller.validator(value: value,isOptional: true),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'reward point',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            //Delivery Time
             Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                controller: controller.deliveryTimeController,
                validator: (value) => controller.validator(value: value,isOptional: true),
                decoration: InputDecoration(
                  hintText: 'Delivery Time',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
    )));
  }
}
