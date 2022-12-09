import 'package:firebase_core/firebase_core.dart';

import 'domain/user.dart';
import 'package:cpmdwithf_project/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/main_tabs/photo.dart';
import 'ui/main_tabs/gallery.dart';
import 'ui/main_tabs/analysis.dart';
import 'package:cpmdwithf_project/domain/image_storage.dart';
import 'screens/auth.dart';
import 'data/theme_change.dart';

// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    const HomePage(),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserOur?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: ChangeNotifierProvider<DarkThemeProvider>(
        create: (context) => DarkThemeProvider(),
        child: EasyLocalization(
          supportedLocales: const [Locale('en', 'US'), Locale('ru', 'RU')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          startLocale: const Locale("en", "US"),
          child: const LandingPage(),
        ),
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  @override
  Widget build(BuildContext context) {
    final themeChangeProvider = context.watch<DarkThemeProvider>();

    final UserOur? user = Provider.of<UserOur?>(context);
    final bool isLoggedIn = user != null;
    return MaterialApp(
      title: 'Car damage analysis',
      theme: ThemeData(
          primarySwatch: Colors.grey,
          brightness: themeChangeProvider.darkTheme
              ? Brightness.dark
              : Brightness.light),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: isLoggedIn ? const MyApp() : const AuthorizationPage(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  static const List<Tab> tabs = <Tab>[
    Tab(
      text: 'Photo',
      icon: Icon(Icons.photo_camera),
    ),
    Tab(
      text: 'Gallery',
      icon: Icon(Icons.browse_gallery),
    ),
    Tab(
      text: 'Analyze',
      icon: Icon(Icons.analytics),
    )
  ];

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return ChangeNotifierProvider<ImageStorage>(
      create: (context) => ImageStorage(),
      child: DefaultTabController(
        length: tabs.length,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: const SafeArea(
              child: TabBar(tabs: tabs),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  themeChange.darkTheme = !themeChange.darkTheme;
                },
                icon: const Icon(Icons.sunny_snowing),
              ),
            ],
          ),
          body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              TakePictureScreen(),
              GalleryScreen(),
              AnalysisScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
