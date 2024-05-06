import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/models/weather_provider.dart';
import 'package:weather_app/presentation/widgets/buttons/brightness_button_widget.dart';

class SettingDialogWidget extends StatefulWidget {
  const SettingDialogWidget({super.key});

  @override
  _SettingDialogWidgetState createState() => _SettingDialogWidgetState();
}

class _SettingDialogWidgetState extends State<SettingDialogWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BrightnessButton(),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Add a new location',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          weatherProvider.addLocation(_controller.text);
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
                            weatherProvider.removeLocation(
                                weatherProvider.weathers[index].cityName);
                            Navigator.of(context).pop();
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
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
