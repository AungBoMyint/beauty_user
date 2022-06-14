import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kozarni_ecome/controller/home_controller.dart';
import 'package:kozarni_ecome/data/constant.dart';
import 'package:kozarni_ecome/service/api.dart';
import 'package:kozarni_ecome/service/database.dart';
import 'package:kozarni_ecome/widgets/show_loading/show_loading.dart';
import 'package:uuid/uuid.dart';

import '../model/product.dart';

class UploadController extends GetxController {
  final RxBool isUploading = false.obs;
  final HomeController _homeController = Get.find();
  final RxMap<String,String> tagsMap = <String,String>{}.obs;
  //Controller
  TextEditingController photo1Controller = TextEditingController();
  TextEditingController photo2Controller = TextEditingController();
  TextEditingController photo3Controller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountPriceController = TextEditingController();
  TextEditingController requirePointController = TextEditingController();
  TextEditingController deliveryTimeController = TextEditingController();

  String advertisementID = "";
  var status = "".obs;
  /**************************** */

  void changeStatus(String value){
    status.value = value;
  }

  void addOrRemoveTag(String key,String value){
    debugPrint("******$key");
    if(tagsMap.containsKey(key)){
      tagsMap.remove(key);
    }else{
      tagsMap[key] = value;
    }
    debugPrint("********${tagsMap.length}");
  }

  @override
  void onInit() {
    super.onInit();

    if (!(_homeController.editItem.value == null)) {
      final editItem = _homeController.editItem.value!;
     photo1Controller.text = editItem.photo1;
     photo2Controller.text = editItem.photo2;
     photo3Controller.text = editItem.photo3;
     nameController.text = editItem.name;
     descriptionController.text = editItem.description;
     sizeController.text = editItem.size ?? "";
     colorController.text = editItem.color ?? "";
     priceController.text = editItem.price.toString();
     discountPriceController.text = editItem.discountPrice.toString();
     requirePointController.text = editItem.requirePoint.toString();
     advertisementID = editItem.advertisementID ?? "";
     deliveryTimeController.text = editItem.deliveryTime ?? "";
     status.value = editItem.status;
     _homeController.changeCat(editItem.category);
     if(editItem.tags.isNotEmpty){
       editItem.tags.forEach((element) { 
         tagsMap.putIfAbsent(element, () => element);
         });
     }
    }
  }

  final Api _api = Api();
  final Database _database = Database();
  final ImagePicker _imagePicker = ImagePicker();

  final RxString filePath = ''.obs;

  final GlobalKey<FormState> form = GlobalKey();
 

  Future<void> pickImage() async {
    try {
      final XFile? _file =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (_file != null) filePath.value = _file.path;
    } catch (e) {
      print("pickImage error $e");
    }
  }

  String? validator({required String? value,required bool isOptional}){
    if((value == null || value.isEmpty) && isOptional){
      return null;
    }else if(value == null || value.isEmpty){
      return "cann't be empty";
    }else{
      return null;
    }
  }
 
  String? requirePointValidator(String? data){
    if((status == rewardStatus) && ((data == null) || (data.isEmpty))){
      return "cann't be empty";
    }else if((status == rewardStatus) && ((int.tryParse(data ?? "0") ?? 0) <= 0)){
      return "must be greater than 0";
    }else if(((int.tryParse(data ?? "0") ?? 0) > 0) && ((
      status != rewardStatus
    ))){
      return "you must be choose 'Beauty Insider Rewards' status";
    }else{
      return null;
    }
  }

  Future<void> delete(String productID) async{
    showLoading();
    await _database.delete(itemCollection, path: productID);
    hideLoading();
  }

  Future<void> upload() async {
    debugPrint("*******EditItemID: ${_homeController.editItem.value!.id}");
    showLoading();
    try {
      if (form.currentState?.validate() == true
          && _homeController.category.isNotEmpty && status.isNotEmpty) {
        final DateTime dateTime = DateTime.now();
        if (_homeController.editItem.value != null) { //For Update
        
          debugPrint("******update***");
          await _database.update(
            itemCollection,
            path: _homeController.editItem.value!.id,
            data: _homeController.editItem.value
                !.copyWith(
                  photo1: photo1Controller.text,
                  photo2: photo2Controller.text,
                  photo3: photo3Controller.text,
                  name: nameController.text,
                  description: descriptionController.text,
                  size: sizeController.text,
                  color: colorController.text,
                  price: int.parse(priceController.text),
                  discountPrice: int.tryParse(discountPriceController.text),
                  requirePoint: int.tryParse(requirePointController.text),
                  advertisementID: advertisementID,
                  status: status.value,
                  category: _homeController.category.value,
                  tags: tagsMap.values.map((e) => e).toList()
                )
                .toJson(),
          );
        } else {//For Upload
          final id = Uuid().v1();
          await _database.write(
            itemCollection,
            path: id,
            data: Product(
              id: id,
              photo1: photo1Controller.text,
                  photo2: photo2Controller.text,
                  photo3: photo3Controller.text,
                  name: nameController.text,
                  description: descriptionController.text,
                  size: sizeController.text,
                  color: colorController.text,
                  price: int.parse(priceController.text),
                  discountPrice: int.tryParse(discountPriceController.text),
                  requirePoint: int.tryParse(requirePointController.text),
                  advertisementID: advertisementID,
                  status: status.value,
                  category: _homeController.category.value,
                  tags: tagsMap.values.map((e) => e).toList(),
                  dateTime: DateTime.now(),
            ).toJson(),
          );
        }
        hideLoading();
        Get.snackbar('Success', 'Uploaded successfully!');
        filePath.value = '';
        return;
      }else{
        hideLoading();
      }
    } catch (e) {
      hideLoading();
      isUploading.value = false;
      print("******Upload Error: $e********");
    }
  }
}
