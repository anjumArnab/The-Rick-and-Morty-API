import 'package:flutter/material.dart';
import 'package:rest_api/models/location.dart';
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    fetchLocationDetails();
  }

  Future<void> fetchLocationDetails() async {
    try {
      LocationModel response = await apiService.fetchLocation(widget.locationUrl);
      setState(() {
        location = response;
        isLoading = false;
      });
    } catch (e) {
      print('Error occurred: $e');
      setState(() {
        isLoading = false;
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
          : (location == null || location!.residents.isEmpty)
              ? const Center(child: Text("No residents found"))
              : ListView.builder(
                  itemCount: location!.residents.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(location!.residents[index]),
                      ),
                    );
                  },
                ),
    );
  }
}
