import 'package:flutter/material.dart';
import 'package:rest_api/screens/charecter_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearching = false; // Flag to check if search is active
  TextEditingController searchController = TextEditingController(); // Controller for search bar
  final List<Map<String, String>> characterData = [
    {
      "imageUrl": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
      "name": "Rick Sanchez",
      "status": "Alive",
      "species": "Human",
      "lastKnownLocation": "Earth (Replacement Dimension)",
      "firstSeen": "Pilot",
    },
    {
      "imageUrl": "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
      "name": "Morty Smith",
      "status": "Alive",
      "species": "Human",
      "lastKnownLocation": "Earth (Replacement Dimension)",
      "firstSeen": "Pilot",
    },
    {
      "imageUrl": "https://rickandmortyapi.com/api/character/avatar/3.jpeg",
      "name": "Summer Smith",
      "status": "Alive",
      "species": "Human",
      "lastKnownLocation": "Earth (Replacement Dimension)",
      "firstSeen": "Pilot",
    },
    {
      "imageUrl": "https://rickandmortyapi.com/api/character/avatar/4.jpeg",
      "name": "Beth Smith",
      "status": "Alive",
      "species": "Human",
      "lastKnownLocation": "Earth (Replacement Dimension)",
      "firstSeen": "Pilot",
    },
    {
      "imageUrl": "https://rickandmortyapi.com/api/character/avatar/5.jpeg",
      "name": "Jerry Smith",
      "status": "Alive",
      "species": "Human",
      "lastKnownLocation": "Earth (Replacement Dimension)",
      "firstSeen": "Pilot",
    },
    {
      "imageUrl": "https://rickandmortyapi.com/api/character/avatar/6.jpeg",
      "name": "Birdperson",
      "status": "Alive",
      "species": "Bird-Person",
      "lastKnownLocation": "Planet Squanch",
      "firstSeen": "Ricksy Business",
    },
    {
      "imageUrl": "https://rickandmortyapi.com/api/character/avatar/7.jpeg",
      "name": "Mr. Meeseeks",
      "status": "Unknown",
      "species": "Meeseeks",
      "lastKnownLocation": "Unknown",
      "firstSeen": "Meeseeks and Destroy",
    }
  ];

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
                  onPressed: () {},
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
            onPressed:(){},
            icon: const Icon(Icons.refresh),
          )
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7,
          ),
          itemCount: characterData.length,
          itemBuilder: (context, index) {
            final character = characterData[index];
            return CharacterCard(
              imageUrl: character["imageUrl"]?.isNotEmpty == true ? character["imageUrl"]! : "",
              name: character["name"]!,
              status: character["status"]!,
              species: character["species"]!,
              lastKnownLocation: character["lastKnownLocation"]!,
              firstSeen: character["firstSeen"]!,
            );
          },
        ),
      ),
    );
  }
}
