import 'package:flutter/material.dart';
import 'package:rest_api/models/location.dart';
import 'package:rest_api/models/residents.dart';  // Fixed typo in import
import 'package:rest_api/services/api_services.dart';

class BottomSheetWidget extends StatefulWidget {
  final String locationUrl;

  const BottomSheetWidget({super.key, required this.locationUrl});

  @override
  // ignore: library_private_types_in_public_api
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  late ApiService apiService;
  LocationModel? location;
  List<ResidentModel> residents = [];  // Fixed: Declare residents
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    fetchLocationDetails(widget.locationUrl);
  }

  Future<void> fetchLocationDetails(String locationUrl) async {
    try {
      LocationModel response = await apiService.fetchLocation(locationUrl);
      List<ResidentModel> fetchedResidents =
          await apiService.fetchResidents(response.residents);

      setState(() {
        location = response;
        residents = fetchedResidents;  // Corrected: Update residents list
        isLoading = false;  // Fixed: Set isLoading to false
      });
    } catch (e) {
      print('Error occurred: $e');
      setState(() {
        isLoading = false;  // Handle errors by stopping the loading state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 400,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (location == null || residents.isEmpty)  // Fixed condition for residents
              ? const Center(child: Text("No residents found"))
              : ListView.builder(
                  itemCount: residents.length,  // Fixed: Use residents list length
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: ClipOval(child: Image.network(residents[index].imageUrl)),
                        title: Text(residents[index].name),
                      ),
                    );
                  },
                ),
    );
  }
}
