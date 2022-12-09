import 'package:firebase_core/firebase_core.dart';

import 'domain/user.dart';
import 'package:cpmdwithf_project/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'ui/main_tabs/photo.dart';
import 'ui/main_tabs/gallery.dart';
import 'ui/main_tabs/analysis.dart';
import 'package:cpmdwithf_project/domain/image_storage.dart';
import 'services/auth.dart';
import 'screens/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const HomePage(),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserOur?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: MaterialApp(
        title: 'Car damage analysis',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const LandingPage(),
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  @override
  Widget build(BuildContext context) {
    final UserOur? user = Provider.of<UserOur?>(context);
    final bool isLoggedIn = user != null;
    return isLoggedIn ? const MyApp() : const AuthorizationPage();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          ),
          body: const TabBarView(
            // 'Jokes screen' uses swiping, so turn off swiping of tabs
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
