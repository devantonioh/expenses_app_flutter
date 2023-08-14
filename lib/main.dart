import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timezone/data/latest_all.dart' as tz;

import 'package:expenses_app/pages/pages.dart';
import 'providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  final prefs = UserPrefs();
  final notifs = LocalNotification();

  await prefs.initPrefs();
  await notifs.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UIProvider()),
        ChangeNotifierProvider(create: (_) => ExpensesProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider(prefs.darkMode)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, value, child) {
      return MaterialApp(
        title: 'Material App',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
        ],
        initialRoute: 'home',
        routes: {
          'home': (context) => const HomePage(),
          'AddEntries': (context) => const AddEntriesPage(),
          'AddExpenses': (context) => const AddExpensesPage(),
          'balance': (context) => const BalancePage(),
          'charts': (context) => const ChartsPage(),
          'catDetails': (context) => const CategoriesDetails(),
          'expDetails': (context) => const ExpensesDetails(),
        },
        theme: value.getTheme(),
      );
    });
  }
}
