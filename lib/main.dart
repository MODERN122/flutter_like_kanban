import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_i18n/loaders/file_translation_loader.dart';
import 'package:likekanban/app.dart';
import 'package:likekanban/services/preference_utils.dart';

void main() async {
  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
      useCountryCode: false,
      fallbackFile: 'en',
      basePath: 'assets/locales',
      forcedLocale: Locale('ru'),
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  PreferenceUtils.init();
  await flutterI18nDelegate.load(null);
  runApp(App(flutterI18nDelegate));
}
