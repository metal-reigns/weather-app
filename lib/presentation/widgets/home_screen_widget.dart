import 'package:flutter/material.dart';
import 'package:weather_app/presentation/widgets/setting_dialog_widget.dart';
import 'package:weather_app/presentation/widgets/buttons/settings_button_widget.dart';
import 'package:weather_app/presentation/widgets/weather_list_widget.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather App")),
      body: Column(
        children: [
          SettingsButtonWidget(
            onPressed: () {
              showLocationDialog(context);
            },
          ),
          const Expanded(child: WeatherList()),
        ],
      ),
    );
  }

  void showLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Dialog(
          child: SettingDialogWidget(),
        );
      },
    );
  }
}
