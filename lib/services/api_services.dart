import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rest_api/models/character_response.dart';


class ApiService {
  // Base URL for the Rick and Morty API
  static const String baseUrl = 'https://rickandmortyapi.com/api/character';

  // Function to fetch characters from the API
  Future<CharacterResponse> fetchCharacters({String? nextPageUrl}) async {
    // Use the provided URL if available, otherwise use the base URL
    final url = nextPageUrl ?? baseUrl;

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // If the response is successful, parse the JSON into the CharacterResponse model
        return CharacterResponse.fromJson(json.decode(response.body));
      } else {
        // Handle error response
        throw Exception('Failed to load characters');
      }
    } catch (e) {
      // Handle any network or parsing error
      throw Exception('Error occurred: $e');
    }
  }

  // Function to fetch characters by location (location URL from the character's location)
  Future<CharacterResponse> fetchCharactersByLocation(String locationUrl) async {
    try {
      final response = await http.get(Uri.parse(locationUrl));

      if (response.statusCode == 200) {
        // Parse the JSON response and return the list of characters
        return CharacterResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load characters by location');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  // Function to fetch characters by origin (origin URL from the character's origin)
  Future<CharacterResponse> fetchCharactersByOrigin(String originUrl) async {
    try {
      final response = await http.get(Uri.parse(originUrl));

      if (response.statusCode == 200) {
        // Parse the JSON response and return the list of characters
        return CharacterResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load characters by origin');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }
}
