import 'package:flutter/material.dart';
import 'package:rest_api/screens/charecter_info.dart';
import 'package:rest_api/services/api_services.dart';
import 'package:rest_api/models/character_response.dart';
import 'package:rest_api/utils/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ApiService apiService;
  List<Character> characters = [];
  bool isLoading = false;
  String? nextPageUrl;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchMoreCharacters();
      }
    });
  }
  Future<void> fetchMoreCharacters() async {
    if (isLoading || nextPageUrl == null) return;
    setState(() => isLoading = true);
    try {
      CharacterResponse response =
          await apiService.fetchCharacters(nextPageUrl: nextPageUrl);
      setState(() {
        characters.addAll(response.results);
        nextPageUrl = response.next;
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        accountName: 'Morty Smith',
        profilePictureUrl:
            'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
        accountEmail: 'mortysmith@gmail.com',
        onExit: () {},
      ),
      appBar: AppBar(title: const Text('The Rick And Morty')),
      body: FutureBuilder<CharacterResponse>(
        future: apiService.fetchCharacters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
            return const Center(child: Text('No characters found'));
          }

          characters = snapshot.data!.results;
          nextPageUrl = snapshot.data!.next;

          return GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              childAspectRatio: 1.4,
            ),
            itemCount: characters.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == characters.length) {
                return const Center(child: CircularProgressIndicator());
              }
              final character = characters[index];
              return Transform.scale(
                scale: 1.0,
                child: CharacterCard(
                  imageUrl: character.image,
                  name: character.name,
                  status: character.status,
                  species: character.species,
                  lastKnownLocation: character.location.name,
                  firstSeen: character.origin.name,
                  locationUrl: character.origin.url,
                ),
              );
            },
          );
        },
      ),
    );
  }
}