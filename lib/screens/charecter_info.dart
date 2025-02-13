import 'package:flutter/material.dart';
import 'package:rest_api/utils/bottom_sheet.dart';

class CharacterCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String status;
  final String species;
  final String lastKnownLocation;
  final String firstSeen;

   CharacterCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.status,
    required this.species,
    required this.lastKnownLocation,
    required this.firstSeen,
  });
  

  Color _getBorderColor(dynamic character) {
    switch (character.status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      case 'unknown':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  
  void _showModalBottomSheet(BuildContext context, String locationUrl) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return BottomSheetWidget(locationUrl: locationUrl);
    },
  );
}

  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getBorderColor(this), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              border: Border(
                  bottom: BorderSide(color: _getBorderColor(this), width: 2)),
            ),
            child: SizedBox(
              width: 200,
              height: 110,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 1),
          Text(
            name,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            '$status - $species',
            style: TextStyle(fontSize: 13, color: Colors.grey[700]),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 13, color: Colors.black),
              children: [
                const TextSpan(
                  text: 'Last known location\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      _showModalBottomSheet(context, "https://rickandmortyapi.com/api/location/1");
                    },
                    child: Text(
                      lastKnownLocation,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 13, color: Colors.black),
              children: [
                const TextSpan(
                  text: 'First seen in\n',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: firstSeen),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
