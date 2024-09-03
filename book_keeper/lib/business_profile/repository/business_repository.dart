import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:book_keeper/business_profile/domain/business_model.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'business_repository.g.dart';

abstract class BusinessRepository {
  Future<BusinessModel> createBusiness(BusinessModel businessModel);
  Future<List<BusinessModel>> getAllBusiness();
  Future<BusinessModel> getBusinessById(int id);
  Future<BusinessModel> updateBusinessById(int id, BusinessModel businessModel);
  Future<BusinessModel> deleteBusinessById(int id);
}

class BusinessImplRepository implements BusinessRepository {
  final baseUrl = dotenv.env['BASE_URL'];
  @override
  Future<BusinessModel> createBusiness(BusinessModel businessModel) async {
    Uri url = Uri.parse('$baseUrl/core/business/');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? '';
    final res = await http.post(
      url,
      body: businessModel.toJson(),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (res.statusCode == 200) {
      return BusinessModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to create business');
    }
  }

  @override
  Future<List<BusinessModel>> getAllBusiness() async {
    Uri url = Uri.parse('$baseUrl/core/business/');
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
      return body.map((dynamic item) => BusinessModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load business');
    }
  }

  @override
  Future<BusinessModel> getBusinessById(int id) async {
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
      return BusinessModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load business');
    }
  }

  @override
  Future<BusinessModel> updateBusinessById(
      int id, BusinessModel businessModel) async {
    Uri url = Uri.parse('$baseUrl/core/business/$id/');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? '';
    final res = await http.patch(
      url,
      body: businessModel.toJson(),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (res.statusCode == 200) {
      return BusinessModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to update business');
    }
  }

  @override
  Future<BusinessModel> deleteBusinessById(int id) async {
    Uri url = Uri.parse('$baseUrl/core/business/$id/');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? '';
    final res = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (res.statusCode == 200) {
      return BusinessModel.fromJson(jsonDecode(res.body));
    } else if (res.statusCode == 401) {
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to delete business');
    }
  }
}

@riverpod
Future<BusinessModel> createBusiness(
    CreateBusinessRef ref, BusinessModel businessModel) async {
  final repository = BusinessImplRepository();
  return repository.createBusiness(businessModel);
}

@riverpod
Future<List<BusinessModel>> getAllBusiness(GetAllBusinessRef ref) async {
  final repository = BusinessImplRepository();
  return repository.getAllBusiness();
}

@riverpod
Future<BusinessModel> getBusinessById(GetBusinessByIdRef ref, int id) async {
  final repository = BusinessImplRepository();
  return repository.getBusinessById(id);
}

@riverpod
Future<BusinessModel> updateBusinessById(
    UpdateBusinessByIdRef ref, int id, BusinessModel businessModel) async {
  final repository = BusinessImplRepository();
  return repository.updateBusinessById(id, businessModel);
}

@riverpod
Future<BusinessModel> deleteBusinessById(
    DeleteBusinessByIdRef ref, int id) async {
  final repository = BusinessImplRepository();
  return repository.deleteBusinessById(id);
}
