import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel{

  final int? id;
  final String? name;
  final String? description;
  @JsonKey(name: 'cost_price')
  final double? costPrice;
  @JsonKey(name: 'selling_price')
  final double? sellingPrice;
  final String? quantity;
  @JsonKey(name: 'business')
  final String? businessId;

  ItemModel({
    this.id,
     this.name,
     this.description,
     this.costPrice,
     this.sellingPrice,
     this.quantity,
     this.businessId
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
  
  Map<String?, dynamic> toJson() => _$ItemModelToJson(this);
}