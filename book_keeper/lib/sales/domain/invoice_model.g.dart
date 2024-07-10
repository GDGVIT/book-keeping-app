// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceModel _$InvoiceModelFromJson(Map<String, dynamic> json) => InvoiceModel(
      amount: (json['amount'] as num).toDouble(),
      billId: json['billId'] as String,
      status: json['status'] as String,
      date: DateTime.parse(json['date'] as String),
      customer: json['customer'] as String,
      customerId: json['customerId'] as String,
    );

Map<String, dynamic> _$InvoiceModelToJson(InvoiceModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'billId': instance.billId,
      'status': instance.status,
      'date': instance.date.toIso8601String(),
      'customer': instance.customer,
      'customerId': instance.customerId,
    };
