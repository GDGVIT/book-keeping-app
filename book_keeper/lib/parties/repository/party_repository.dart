import 'dart:convert';
import 'package:book_keeper/parties/domain/party_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'party_repository.g.dart';

abstract class PartyRepository {
  Future<PartyModel> createParty(PartyModel party);
  Future<List<PartyModel>> getAllParties();
  Future<PartyModel> getPartyById(int id);
  Future<PartyModel> updateParty(int id, PartyModel party);
  Future<void> deleteParty(int id);
}

class PartyImplRepository implements PartyRepository {
  final baseUrl = dotenv.env['BASE_URL'];

  @override
  Future<PartyModel> createParty(PartyModel party) async {
    Uri url = Uri.parse('$baseUrl/core/parties/');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? '';
    final res = await http.post(
      url,
      body: party.toJson(),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (res.statusCode == 200) {
      return PartyModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to create business');
    }
  }

  @override
  Future<List<PartyModel>> getAllParties() async {
    Uri url = Uri.parse('$baseUrl/core/parties/');
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
      return body.map((dynamic item) => PartyModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load business');
    }
  }

  @override
  Future<PartyModel> getPartyById(int id) async {
    Uri url = Uri.parse('$baseUrl/core/parties/$id/');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? '';
    final res = await http.get(url, headers: {
      'Authorization': 'Bearer $accessToken',
    });
    if (res.statusCode == 200) {
      return PartyModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load business');
    }
  }

  @override
  Future<PartyModel> updateParty(int id, PartyModel party) async {
    Uri url = Uri.parse('$baseUrl/core/parties/$id/');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token') ?? '';
    final res = await http.patch(
      url,
      body: party.toJson(),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (res.statusCode == 200) {
      return PartyModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load business');
    }
  }

  @override
  Future<void> deleteParty(int id) async {
    Uri url = Uri.parse('$baseUrl/core/parties/$id/');
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
      throw Exception('Failed to delete business');
    }
  }
}

@riverpod
Future<PartyModel> createParty(CreatePartyRef ref, PartyModel party) async {
  final repository = PartyImplRepository();
  return repository.createParty(party);
}

@riverpod
Future<List<PartyModel>> getAllParties(GetAllPartiesRef ref) async {
  final repository = PartyImplRepository();
  return repository.getAllParties();
}

@riverpod
Future<PartyModel> getPartyById(GetPartyByIdRef ref, int id) async {
  final repository = PartyImplRepository();
  return repository.getPartyById(id);
}

@riverpod
Future<PartyModel> updateParty(
    UpdatePartyRef ref, int id, PartyModel businessModel) async {
  final repository = PartyImplRepository();
  return repository.updateParty(id, businessModel);
}

@riverpod
Future<void> deleteParty(DeletePartyRef ref, int id) async {
  final repository = PartyImplRepository();
  return repository.deleteParty(id);
}
