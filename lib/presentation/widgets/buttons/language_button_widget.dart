import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/models/weather_provider.dart';
import 'package:weather_app/i18n/translations.g.dart';

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context, listen: false);
    return IconButton(
      icon: const Icon(Icons.language),
      onPressed: () {
        var newLocale = model.currentLocale == 'en' ? 'ru' : 'en';
        model.currentLocale = newLocale;
        setSlangLocale(newLocale);
      },
    );
  }
}

void setSlangLocale(String newLocale) {
  LocaleSettings.setLocale(newLocale == 'en' ? AppLocale.en : AppLocale.ru);
}
