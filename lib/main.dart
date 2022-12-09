import 'package:firebase_core/firebase_core.dart';

import 'domain/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'ui/main_tabs/photo.dart';
import 'ui/main_tabs/gallery.dart';
import 'ui/main_tabs/analysis.dart';
import 'package:cpmdwithf_project/domain/image_storage.dart';
import 'services/auth.dart';
import 'screens/auth.dart';
import 'data/theme_change.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const HomePage(),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // DarkThemeProvider themeChangeProvider = DarkThemeProvider();

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
        child: const LandingPage(),
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
      darkTheme: ThemeData(
        primarySwatch: Colors.grey,
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      home: isLoggedIn ? const MyApp() : const AuthorizationPage(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

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
                  print(themeChange.darkTheme);
                  setState(() {});
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
