import 'package:json_annotation/json_annotation.dart';

part 'invoice_model.g.dart';

@JsonSerializable()
class InvoiceModel{
    // Amount
    // Bill Id
    // Status
    // Date
    // Customer 
    // Customer ID

    final double amount;
    final String billId;
    final String status;
    final DateTime date;
    final String customer;
    final String customerId;

    InvoiceModel({
        required this.amount,
        required this.billId,
        required this.status,
        required this.date,
        required this.customer,
        required this.customerId
    });

    factory InvoiceModel.fromJson(Map<String, dynamic> json) => _$InvoiceModelFromJson(json);

    Map<String, dynamic> toJson() => _$InvoiceModelToJson(this);
}