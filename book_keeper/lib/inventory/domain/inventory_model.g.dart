// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryModel _$InventoryModelFromJson(Map<String, dynamic> json) =>
    InventoryModel(
      inventoryName: json['inventoryName'] as String,
      inventoryId: json['inventoryId'] as String,
      inventoryDescription: json['inventoryDescription'] as String,
      inventoryPrice: (json['inventoryPrice'] as num).toDouble(),
      inventoryQuantity: (json['inventoryQuantity'] as num).toInt(),
      inventoryCategory: json['inventoryCategory'] as String,
      inventoryVendor: json['inventoryVendor'] as String,
      inventoryDate: json['inventoryDate'] as String,
      inventoryTime: json['inventoryTime'] as String,
    );

Map<String, dynamic> _$InventoryModelToJson(InventoryModel instance) =>
    <String, dynamic>{
      'inventoryName': instance.inventoryName,
      'inventoryId': instance.inventoryId,
      'inventoryDescription': instance.inventoryDescription,
      'inventoryPrice': instance.inventoryPrice,
      'inventoryQuantity': instance.inventoryQuantity,
      'inventoryCategory': instance.inventoryCategory,
      'inventoryVendor': instance.inventoryVendor,
      'inventoryDate': instance.inventoryDate,
      'inventoryTime': instance.inventoryTime,
    };
