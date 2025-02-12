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
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  late ApiService apiService;
  List<Character> characters = []; // Added list to store characters
  bool isLoading = false; // Track loading state
  String? nextPageUrl; // Store next page URL
  final ScrollController _scrollController = ScrollController(); // Added scroll controller

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    fetchInitialCharacters();

    // Listener for scroll events
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        fetchMoreCharacters();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose scroll controller
    super.dispose();
  }

  Future<void> fetchInitialCharacters() async {
    setState(() => isLoading = true);
    try {
      CharacterResponse response = await apiService.fetchCharacters();
      setState(() {
        characters = response.results;
        nextPageUrl = response.next;
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchMoreCharacters() async {
    if (isLoading || nextPageUrl == null) return;
    setState(() => isLoading = true);
    try {
      CharacterResponse response = await apiService.fetchCharacters(nextPageUrl: nextPageUrl);
      setState(() {
        characters.addAll(response.results);
        nextPageUrl = response.next;
      });
    } finally {
      setState(() => isLoading = false);
    }
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
                onChanged: (_) {},
              )
            : const Text('The Rick And Morty'),
        actions: [
          isSearching
              ? IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    setState(() => isSearching = false);
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() => isSearching = true);
                  },
                ),
          IconButton(
            onPressed: fetchInitialCharacters,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          controller: _scrollController, // Added scroll controller
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7,
          ),
          itemCount: characters.length + (isLoading ? 1 : 0), // Added loading indicator item
          itemBuilder: (context, index) {
            if (index == characters.length) {
              return const Center(child: CircularProgressIndicator()); // Show loader at end
            }
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
      ),
    );
  }
}
