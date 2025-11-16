import 'package:blog_app/App_UI/Home/home.dart';
import 'package:blog_app/Helpre_Classh/Provider/Comment/get_comment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'App_UI/welcome_screen.dart';
import 'App_UI/Auth/Login/login.dart';
import 'Helpre_Classh/Provider/Details/details_provider.dart';
import 'Helpre_Classh/Provider/BookMarks/bookmarks_provider.dart';
import 'Helpre_Classh/Provider/Blog/blog_provider.dart';
import 'Helpre_Classh/Provider/Usre_Provider/user_provider.dart';
import 'Helpre_Classh/Provider/Like/like_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await GetStorage.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => DetailsProvider()),
        ChangeNotifierProvider(create: (_) => BookmarksProvider()),
        ChangeNotifierProvider(create: (_) => BlogProvider()),
        ChangeNotifierProvider(create: (_) => GetCommentProvider()),
        ChangeNotifierProvider(create: (_) => LikeProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  final box = GetStorage();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        final token = box.read('token');
        final isNotFirstTime = box.read('isNotFirstTime');
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(),
          home: (isNotFirstTime == null || isNotFirstTime == false) ? WelcomeScreen() : (token != null) ? Home() : Login(),
        );
      },
    );
  }
}

