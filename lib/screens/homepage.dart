import 'package:flutter/material.dart';
import 'package:rest_api/screens/charecter_info.dart';
import 'package:rest_api/services/api_services.dart';
import 'package:rest_api/models/character_response.dart';
import 'package:rest_api/models/location.dart';
import 'package:rest_api/models/episode.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearching = false; // Flag to check if search is active
  TextEditingController searchController = TextEditingController(); // Controller for search bar

  late ApiService apiService;
  late Future<CharacterResponse> charactersFuture;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    charactersFuture = apiService.fetchCharacters();
  }

  // Function to fetch location details
  Future<LocationModel> fetchLocation(String locationUrl) async {
    return await apiService.fetchLocation(locationUrl);
  }

  // Function to fetch episode details
  Future<EpisodeModel> fetchEpisode(String episodeUrl) async {
    return await apiService.fetchEpisode(episodeUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search by Character, Episode or Location...',
                  hintStyle: TextStyle(color: Colors.black),
                ),
                onChanged: (_){
                  // Add search functionality here
                },
              )
            : const Text('The Rick And Morty'),
        actions:[
          isSearching
              ? IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                ),
          IconButton(
            onPressed: () {
              setState(() {
                charactersFuture = apiService.fetchCharacters(); // Refresh data
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ]
      ),
      body: FutureBuilder<CharacterResponse>(
        future: charactersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
            return const Center(child: Text('No characters found'));
          } else {
            final characters = snapshot.data!.results;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  final character = characters[index];
                  return CharacterCard(
                    imageUrl: character.image,
                    name: character.name,
                    status: character.status,
                    species: character.species,
                    lastKnownLocation: character.location.name,
                    firstSeen: character.episode.isNotEmpty ? character.episode[0] : '',
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
