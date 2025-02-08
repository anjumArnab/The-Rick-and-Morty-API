import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rest_api/models/api_response.dart';
import 'package:rest_api/models/character.dart';
import 'package:rest_api/models/episode.dart';
import 'package:rest_api/models/location.dart';

class ApiService {
  final String baseUrl = "https://rickandmortyapi.com/api";

  // Method to fetch all characters
  Future<ApiResponse<Character>> fetchAllCharacters({
    int page = 1,
  }) async {
    final response = await http.get(Uri.parse('$baseUrl/character?page=$page'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ApiResponse<Character>.fromJson(
          data, (json) => Character.fromJson(json));
    } else {
      throw Exception('Failed to load characters');
    }
  }

  // Method to fetch all characters with optional filters
  Future<ApiResponse<Character>> fetchCharacters({
    int page = 1,
    String? name,
    String? status,
    String? species,
    String? type,
    String? gender,
  }) async {
    String query = '?page=$page';
    if (name != null) query += '&name=$name';
    if (status != null) query += '&status=$status';
    if (species != null) query += '&species=$species';
    if (type != null) query += '&type=$type';
    if (gender != null) query += '&gender=$gender';

    final response = await http.get(Uri.parse('$baseUrl/character$query'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ApiResponse<Character>.fromJson(
          data, (json) => Character.fromJson(json));
    } else {
      throw Exception('Failed to load characters');
    }
  }

  // Method to fetch locations
  Future<ApiResponse<Location>> fetchAllLocations({int page = 1}) async {
    final response = await http.get(Uri.parse('$baseUrl/location?page=$page'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ApiResponse<Location>.fromJson(
          data, (json) => Location.fromJson(json));
    } else {
      throw Exception('Failed to load locations');
    }
  }

  // Method to fetch all locations with optional filters
  Future<ApiResponse<Location>> fetchLocations({
    int page = 1,
    String? name,
    String? type,
    String? dimension,
  }) async {
    String query = '?page=$page';
    if (name != null) query += '&name=$name';
    if (type != null) query += '&type=$type';
    if (dimension != null) query += '&dimension=$dimension';

    final response = await http.get(Uri.parse('$baseUrl/location$query'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ApiResponse<Location>.fromJson(
          data, (json) => Location.fromJson(json));
    } else {
      throw Exception('Failed to load locations');
    }
  }

// Method to fetch all episodes
  Future<ApiResponse<Episode>> fetchAllEpisodes({
    int page = 1,
  }) async {
    final response = await http.get(Uri.parse('$baseUrl/episode?page=$page'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ApiResponse<Episode>.fromJson(
          data, (json) => Episode.fromJson(json));
    } else {
      throw Exception('Failed to load episodes');
    }
  }

  // Method to fetch all episodes with optional filters
  Future<ApiResponse<Episode>> fetchEpisodes({
    int page = 1,
    String? name,
    String? episode,
  }) async {
    String query = '?page=$page';
    if (name != null) query += '&name=$name';
    if (episode != null) query += '&episode=$episode';

    final response = await http.get(Uri.parse('$baseUrl/episode$query'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return ApiResponse<Episode>.fromJson(
          data, (json) => Episode.fromJson(json));
    } else {
      throw Exception('Failed to load episodes');
    }
  }
}
