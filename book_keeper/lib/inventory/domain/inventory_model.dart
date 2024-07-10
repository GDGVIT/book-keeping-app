import 'package:json_annotation/json_annotation.dart';

part 'inventory_model.g.dart';

@JsonSerializable()
class InventoryModel{
  final String inventoryName;
  final String inventoryId;
  final String inventoryDescription;
  final double inventoryPrice;
  final int inventoryQuantity;
  final String inventoryCategory;
  final String inventoryVendor;
  final String inventoryDate;
  final String inventoryTime;

  InventoryModel({
    required this.inventoryName,
    required this.inventoryId,
    required this.inventoryDescription,
    required this.inventoryPrice,
    required this.inventoryQuantity,
    required this.inventoryCategory,
    required this.inventoryVendor,
    required this.inventoryDate,
    required this.inventoryTime,
  });

  factory InventoryModel.fromJson(Map<String, dynamic> json) =>
      _$InventoryModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$InventoryModelToJson(this);
}