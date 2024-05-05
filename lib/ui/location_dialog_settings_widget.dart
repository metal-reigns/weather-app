import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/weather_provider.dart';

class LocationDialog extends StatefulWidget {
  @override
  _LocationDialogState createState() => _LocationDialogState();
}

class _LocationDialogState extends State<LocationDialog> {
  final TextEditingController _controller = TextEditingController();
  List<String> locations = [];

  @override
  Widget build(BuildContext context) {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Add a new location',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      Provider.of<WeatherProvider>(context, listen: false)
                          .addLocation(_controller.text);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: weatherProvider.weathers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(weatherProvider.weathers[index].cityName),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        Provider.of<WeatherProvider>(context, listen: false)
                            .removeLocation(locations[index]);
                        Navigator.of(context)
                            .pop(); // Опционально, если вы хотите закрыть диалог после удаления
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
