import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pakai_mart/providers/auth.dart';
import 'package:pakai_mart/providers/button_and_title.dart';
import 'package:pakai_mart/providers/users_receiver_data.dart';
import 'package:pakai_mart/providers/woman_categories.dart';
import 'package:pakai_mart/providers/woman_overviews.dart';
import 'package:pakai_mart/screens/auth_screen.dart';
import 'package:pakai_mart/screens/splash_screen.dart';
import 'package:pakai_mart/screens/casheer_screen/user_form_screen.dart';
import 'package:pakai_mart/screens/clothes_screen/detail_screen.dart';
import 'package:pakai_mart/screens/clothes_screen/woman_category_screen.dart';
import 'package:pakai_mart/screens/clothes_screen/woman_overview_screen.dart';
import 'package:provider/provider.dart';
import './screens/clothes_screen/atas_bawah_screen.dart';
import './screens/clothes_screen/luar_dalam_screen.dart';
import './tabs_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: WomanCategories(),
        ),
        ChangeNotifierProvider.value(
          value: WomanOverviews(),
        ),
        ChangeNotifierProvider.value(
          value: ButtonAndTitle(),
        ),
        ChangeNotifierProvider.value(
          value: ListOfUserReciever(),
        ),
      ], // provider class
      child: Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: auth.isAuth
              ? TabsScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            LuarDalamScreen.routeName: (ctx) => LuarDalamScreen(),
            AtasBawahScreen.routeName: (ctx) => AtasBawahScreen(),
            WomanCategoryScreen.routeName: (ctx) => WomanCategoryScreen(),
            WomanOverviewScreen.routeName: (ctx) => WomanOverviewScreen(),
            DetailScreen.routeName: (ctx) => DetailScreen(),
            UserFormScreen.routeName: (ctx) => UserFormScreen(),
            // '/BawahKategori'
          },
        ),
      ),
    );
  }
}
