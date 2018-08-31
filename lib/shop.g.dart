// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Shop _$ShopFromJson(Map<String, dynamic> json) => new Shop(
    json['name'] as String, json['address'] as String, json['iconCode'] as int);

abstract class _$ShopSerializerMixin {
  String get name;
  String get address;
  int get iconCode;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'name': name, 'address': address, 'iconCode': iconCode};
}
