/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 68 (34 per locale)
///
/// Built on 2024-05-07 at 14:54 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build),
	ru(languageCode: 'ru', build: _TranslationsRu.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  );

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	late final Translations _root = this; // ignore: unused_field

	// Translations
	String get title => 'Weather App';
	String get current_weather => 'Current Weather';
	String get forecast => 'Forecast';
	String get humidity => 'Humidity';
	String get pressure => 'Pressure';
	String get wind_speed => 'Wind Speed';
	String get speed_unit => 'м/с';
	String get temperature => 'Temperature';
	String get feels_like => 'Feels Like';
	String get visibility => 'Visibility';
	String get add_location => 'Add Location';
	String get delete_location => 'Delete Location';
	String get search_city => 'Search for a city...';
	String get settings => 'Settings';
	String get change_language => 'Change Language';
	String get toggle_theme => 'Toggle Theme';
	String get distance => 'Distance';
	String get distance_unit => 'km';
	String get last_update_time => 'Last update';
	String get h_pa => 'hPa';
	String get rain => 'Rain';
	String get snow => 'Snow';
	String get clouds => 'Clouds';
	late final _TranslationsDaysEn days = _TranslationsDaysEn._(_root);
	String get now => 'now';
	String get day_ago => 'day ago';
	String get hour_ago => 'hours ago';
	String get minutes_ago => 'minutes ago';
}

// Path: days
class _TranslationsDaysEn {
	_TranslationsDaysEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get monday => 'Mon';
	String get tuesday => 'Tue';
	String get wednesday => 'Wed';
	String get thursday => 'Thu';
	String get friday => 'Fri';
	String get saturday => 'Sat';
	String get sunday => 'Sun';
}

// Path: <root>
class _TranslationsRu extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsRu.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super.build(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

	/// Metadata for the translations of <ru>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	@override late final _TranslationsRu _root = this; // ignore: unused_field

	// Translations
	@override String get title => 'Приложение прогноза погода';
	@override String get current_weather => 'Текущая погода';
	@override String get forecast => 'Прогноз';
	@override String get humidity => 'Влажность';
	@override String get pressure => 'Давление';
	@override String get wind_speed => 'Скорость ветра';
	@override String get speed_unit => 'm/s';
	@override String get temperature => 'Температура';
	@override String get feels_like => 'Ощущается как';
	@override String get visibility => 'Видимость';
	@override String get add_location => 'Добавить местоположение';
	@override String get delete_location => 'Удалить местоположение';
	@override String get search_city => 'Поиск города...';
	@override String get settings => 'Показать настройки';
	@override String get change_language => 'Сменить язык';
	@override String get toggle_theme => 'Переключить тему';
	@override String get distance => 'Расстояние';
	@override String get distance_unit => 'Км';
	@override String get last_update_time => 'Последнее обновление';
	@override String get h_pa => 'гПа';
	@override String get rain => 'Дождь';
	@override String get snow => 'Снег';
	@override String get clouds => 'Облачность';
	@override late final _TranslationsDaysRu days = _TranslationsDaysRu._(_root);
	@override String get now => 'Только что';
	@override String get day_ago => 'дней назад';
	@override String get hour_ago => 'часов назад';
	@override String get minutes_ago => 'минут назад';
}

// Path: days
class _TranslationsDaysRu extends _TranslationsDaysEn {
	_TranslationsDaysRu._(_TranslationsRu root) : this._root = root, super._(root);

	@override final _TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get monday => 'Пн';
	@override String get tuesday => 'Вт';
	@override String get wednesday => 'Ср';
	@override String get thursday => 'Чт';
	@override String get friday => 'Пт';
	@override String get saturday => 'Сб';
	@override String get sunday => 'Вс';
}
