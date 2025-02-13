import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rest_api/models/character_response.dart';
import 'package:rest_api/models/location.dart';
import 'package:rest_api/models/episode.dart';
import 'package:rest_api/models/residents.dart';

class ApiService {
  static const String baseUrl = 'https://rickandmortyapi.com/api/character';

  Future<CharacterResponse> fetchCharacters({String? nextPageUrl}) async {
    final url = nextPageUrl ?? baseUrl;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return CharacterResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load characters');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  // Fetch location details by URL
  Future<LocationModel> fetchLocation(String locationUrl) async {
    try {
      final response = await http.get(Uri.parse(locationUrl));
      if (response.statusCode == 200) {
        return LocationModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load location');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

// Fetch episode details by URL
Future<EpisodeModel> fetchEpisode(String locationUrl) async {
    try {
      final response = await http.get(Uri.parse(locationUrl));
      if (response.statusCode == 200) {
        return EpisodeModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load location');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<List<ResidentModel>> fetchResidents(List<String> residentUrls) async {
  List<ResidentModel> residents = [];

  for (String url in residentUrls) {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        residents.add(ResidentModel.fromJson(json.decode(response.body)));
      }
    } catch (e) {
      print('Error fetching resident: $e');
    }
  }

  return residents;
}


}
