import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product{
  factory Product({
  required  String id,
  required String photo1,
  required String photo2,
  required String photo3,
  required String name,
  required String description,
  required int price,
  @JsonKey(defaultValue: 0)
  int? discountPrice,
  @JsonKey(nullable: true)
   String? size,
   @JsonKey(nullable: true)
   String? color,
  @JsonKey(defaultValue: 0)
  int? requirePoint,
  @JsonKey(nullable: true)
 String? advertisementID,
  required String status,
  required String category,
  required List<String> tags,
  required DateTime dateTime,
  @JsonKey(nullable: true)
  String? deliveryTime,
  @JsonKey(defaultValue: 0)
  int? love,
  @JsonKey(defaultValue: [])
  List<String>? comment,
  }) = _Product;

  factory Product.fromJson(Map<String,dynamic> json) => _$ProductFromJson(json);
}