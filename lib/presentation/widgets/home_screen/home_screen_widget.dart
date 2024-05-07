import 'package:flutter/material.dart';
import 'package:weather_app/i18n/translations.g.dart';
import 'package:weather_app/presentation/widgets/dialog/setting_dialog_widget.dart';
import 'package:weather_app/presentation/widgets/buttons/settings_button_widget.dart';
import 'package:weather_app/presentation/widgets/weather/weather_list_widget.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    final t = TranslationProvider.of(context).translations;
    return Scaffold(
      appBar: AppBar(title: Text(t.title)),
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
        return Dialog(
          child: SettingDialogWidget(),
        );
      },
    );
  }
}
