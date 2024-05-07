import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/models/weather_provider.dart';
import 'package:weather_app/i18n/translations.g.dart';
import 'package:weather_app/presentation/widgets/buttons/brightness_button_widget.dart';
import 'package:weather_app/presentation/widgets/buttons/language_button_widget.dart';

class SettingDialogWidget extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  SettingDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = TranslationProvider.of(context).translations;
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(t, weatherProvider, context),
                _buildWeatherList(weatherProvider, context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(
      Translations t, WeatherProvider weatherProvider, BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: t.add_location,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const BrightnessButton(),
            const LanguageToggleButton(),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  weatherProvider.addLocation(
                      _controller.text, weatherProvider.currentLocale);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherList(
      WeatherProvider weatherProvider, BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: weatherProvider.weathers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(weatherProvider.weathers[index].cityName),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                weatherProvider
                    .removeLocation(weatherProvider.weathers[index].cityName);
                Navigator.of(context).pop();
              },
            ),
          );
        },
      ),
    );
  }
}
