import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:book_keeper/sales/domain/transaction_model.dart';
import 'package:http/http.dart' as http;

part 'transaction_repository.g.dart';

abstract class TransactionRepository {
  Future<TransactionModel> createTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> getAllTransactions();
  Future<TransactionModel> getTransactionById(int id);
  Future<TransactionModel> updateTransaction(
      TransactionModel transaction, int id);
  Future<void> deleteTransaction(int id);
}

class TransactionImplRepository implements TransactionRepository {
  final baseUrl = dotenv.env['BASE_URL'];
  @override
  Future<TransactionModel> createTransaction(
      TransactionModel transaction) async {
    Uri url = Uri.parse('$baseUrl/core/transactions/');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? '';
    final res = await http.post(
      url,
      body: transaction.toJson(),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (res.statusCode == 200) {
      return TransactionModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to create item');
    }
  }

  @override
  Future<void> deleteTransaction(int id) async {
    Uri url = Uri.parse('$baseUrl/core/transactions/$id/');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? '';
    final res = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (res.statusCode == 200) {
      //
    } else if (res.statusCode == 401) {
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to delete item');
    }
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    Uri url = Uri.parse('$baseUrl/core/transactions/');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? '';
    final res = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (res.statusCode == 200) {
      final List<dynamic> body = jsonDecode(res.body);
      return body
          .map((dynamic item) => TransactionModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load business');
    }
  }

  @override
  Future<TransactionModel> getTransactionById(int id) async {
    Uri url = Uri.parse('$baseUrl/core/business/$id/');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? '';
    final res = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (res.statusCode == 200) {
      return TransactionModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load business');
    }
  }

  @override
  Future<TransactionModel> updateTransaction(
      TransactionModel transaction, int id) async {
    Uri url = Uri.parse('$baseUrl/core/business/$id/');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? '';
    final res = await http.patch(
      url,
      body: transaction.toJson(),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (res.statusCode == 200) {
      return TransactionModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to update business');
    }
  }
}

@riverpod
Future<TransactionModel> createTransaction(
    CreateTransactionRef ref, TransactionModel transaction) async {
  final repository = TransactionImplRepository();
  return repository.createTransaction(transaction);
}

@riverpod
Future<List<TransactionModel>> getAllTransaction(
    GetAllTransactionRef ref) async {
  final repository = TransactionImplRepository();
  return repository.getAllTransactions();
}

@riverpod
Future<TransactionModel> getTransactionById(
    GetTransactionByIdRef ref, int id) async {
  final repository = TransactionImplRepository();
  return repository.getTransactionById(id);
}

@riverpod
Future<TransactionModel> updateTransaction(
    UpdateTransactionRef ref, int id, TransactionModel transaction) async {
  final repository = TransactionImplRepository();
  return repository.updateTransaction(transaction, id);
}

@riverpod
Future<void> deleteTransaction(DeleteTransactionRef ref, int id) async {
  final repository = TransactionImplRepository();
  return repository.deleteTransaction(id);
}
