import 'dart:convert';

import 'package:book_keeper/inventory/domain/item_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'item_repository.g.dart';

abstract class ItemRepository {
  Future<ItemModel> getItem(int id);
  Future<List<ItemModel>> getItemsForBusiness(int businessId);
  Future<ItemModel> createItem(ItemModel item);
  Future<ItemModel> updateItem(int id, ItemModel item);
  Future<ItemModel> deleteItem(int id);
}

class ItemImplRepository implements ItemRepository {
  final baseUrl = dotenv.env['BASE_URL'];

  @override
  Future<ItemModel> createItem(ItemModel item) async {
    Uri url = Uri.parse('$baseUrl/item/');
    final res = await http.post(
      url,
      body: item.toJson(),
    );
    if (res.statusCode == 200) {
      return ItemModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to create item');
    }
  }

  @override
  Future<ItemModel> deleteItem(int id) async {
    Uri url = Uri.parse('$baseUrl/item/$id/');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? '';
    final res = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (res.statusCode == 200) {
      return ItemModel.fromJson(jsonDecode(res.body));
    } else if (res.statusCode == 401) {
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to delete item');
    }
  }

  @override
  Future<ItemModel> getItem(int id) async {
    Uri url = Uri.parse('$baseUrl/item/$id/');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      return ItemModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load item');
    }
  }

  @override
  Future<List<ItemModel>> getItemsForBusiness(int businessId) async {
    Uri url = Uri.parse('$baseUrl/item/?business=$businessId');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final List<dynamic> body = jsonDecode(res.body);
      return body.map((dynamic item) => ItemModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  @override
  Future<ItemModel> updateItem(int id, ItemModel item) async {
    Uri url = Uri.parse('$baseUrl/item/$id/');
    final res = await http.put(
      url,
      body: item.toJson(),
    );
    if (res.statusCode == 200) {
      return ItemModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to update item');
    }
  }
}


@riverpod
Future<ItemModel> createItem(CreateItemRef ref,ItemModel item) async {
  final repository=ItemImplRepository();
  return repository.createItem(item);
}

@riverpod
Future<ItemModel> deleteItem(DeleteItemRef ref,int id) async {
  final repository=ItemImplRepository();
  return repository.deleteItem(id);
}

@riverpod
Future<ItemModel> getItem(GetItemRef ref,int id) async {
  final repository=ItemImplRepository();
  return repository.getItem(id);
}

@riverpod
Future<List<ItemModel>> getItemsForBusiness(GetItemsForBusinessRef ref,int businessId) async {
  final repository=ItemImplRepository();
  return repository.getItemsForBusiness(businessId);
}

@riverpod
Future<ItemModel> updateItem(UpdateItemRef ref,int id,ItemModel item) async {
  final repository=ItemImplRepository();
  return repository.updateItem(id,item);
}

