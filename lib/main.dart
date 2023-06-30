import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tiktok_clone/common/widget/main_navigation/widgets/video_configration/video_config.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );

  runApp(const TikTokApp());
}

class TikTokApp extends StatefulWidget {
  const TikTokApp({super.key});

  @override
  State<TikTokApp> createState() => _TikTokAppState();
}

class _TikTokAppState extends State<TikTokApp> {
  @override
  Widget build(BuildContext context) {
    S.load(const Locale("ko"));
    return ValueListenableBuilder(
      valueListenable: darkMode,
      builder: (context, value, child) => MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'TikTok Clone',
        localizationsDelegates: const [
          S.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("en"),
          Locale("ko"),
        ],
        themeMode: darkMode.value ? ThemeMode.light : ThemeMode.dark,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: Typography.blackCupertino,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade50,
          ),
          primaryColor: const Color(
            0xFFE9435A,
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(
              0xFFE9435A,
            ),
          ),
          splashColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w800,
            ),
          ),
          tabBarTheme: TabBarTheme(
            unselectedLabelColor: Colors.grey.shade500,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
          ),
          listTileTheme: const ListTileThemeData(
            iconColor: Colors.black,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          tabBarTheme: TabBarTheme(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade700,
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(
              0xFFE9435A,
            ),
          ),
          textTheme: Typography.whiteCupertino,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            surfaceTintColor: Colors.white,
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w800,
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.grey.shade100,
            ),
            iconTheme: IconThemeData(
              color: Colors.grey.shade100,
            ),
            centerTitle: true,
            backgroundColor: Colors.grey.shade900,
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade900,
          ),
          primaryColor: const Color(
            0xFFE9435A,
          ),
        ),
      ),
    );
  }
}
