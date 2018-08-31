import 'package:json_annotation/json_annotation.dart';

part 'shop.g.dart';

@JsonSerializable()
class Shop extends Object with _$ShopSerializerMixin {
  String name;
  String address;
  int iconCode;

  Shop(this.name, this.address, this.iconCode);

//  Shop.fromJson(Map<String, dynamic> json)
//      : name = json['name'],
//        address = json['address'],
//        iconCode = json['iconCode'];

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);
}