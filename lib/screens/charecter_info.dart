import 'package:flutter/material.dart';
import 'package:rest_api/utils/bottom_sheet.dart';

class CharacterCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String status;
  final String species;
  final String lastKnownLocation;
  final String firstSeen;
  final String locationUrl;

  const CharacterCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.status,
    required this.species,
    required this.lastKnownLocation,
    required this.firstSeen,
    required this.locationUrl,
  });

  Color _getBorderColor() {
    switch (status.toLowerCase()) {
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

  void _showModalBottomSheet(BuildContext context) {
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getBorderColor(), width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '$status - $species',
                      style: const TextStyle(
                          fontSize: 13, color: Colors.white70),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 13, color: Colors.white),
                        children: [
                          const TextSpan(
                            text: 'Last known location\n',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                _showModalBottomSheet(context);
                              },
                              child: Text(
                                lastKnownLocation,
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 13, color: Colors.white),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
