import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  final int? id;
  final String? type;
  final String? date;
  final double? amount;
  @JsonKey(name: "party")
  final String? partyId;
  @JsonKey(name: "item")
  final String? itemId;

  TransactionModel({
    this.id,
    this.amount,
    this.date,
    this.type,
    this.itemId,
    this.partyId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
