import 'package:blog_app/Helpre_Classh/Provider/BookMarks/bookmarks_provider.dart';
import 'package:blog_app/Helpre_Classh/Provider/Usre_Provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'Blog/blog_appbar.dart';
import 'Blog/blog_screen.dart';
import 'Bookmarks/bookmarks_appbar.dart';
import 'Bookmarks/bookmarks_screen.dart';
import '../Auth/Profile/profile.dart';
import 'package:blog_app/App_UI/Search/search_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _appbarTitle = [BlogAppbar(), BookmarksAppbar()];

  final List<Widget> _pages = [BlogBody(), BookmarksBody()];

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: _currentIndex == 1
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                icon: Icon(Icons.arrow_back, size: 25.sp, color: Colors.white),
              )
            : null,
        title: _currentIndex < 2
            ? _appbarTitle[_currentIndex]
            : SizedBox.shrink(),
        centerTitle: true,
        actions: _currentIndex == 0
            ? [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                  icon: Icon(Icons.search, size: 25.sp, color: Colors.white),
                ),
                SizedBox(width: 20),
              ]
            : null,
      ),
      body: _currentIndex < 2 ? _pages[_currentIndex] : Container(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF292E38),
        selectedItemColor: Color(0xFFffffff),
        unselectedItemColor: Color(0xFF9EA6BA),
        currentIndex: _currentIndex,
        onTap: (index) async{
          if (index < 2) {
            setState(() {
              _currentIndex = index;
            });
            if(_currentIndex == 1){
              await context.read<BookmarksProvider>().bookmarks();
            }
          } else {
            final res = await context.read<UserProvider>().getUserProfileData();
            if(res != null && res.success == true){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
            }
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, size: 25.sp),
            label: 'Blog',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 1
                  ? Icons.bookmarks_rounded
                  : Icons.bookmarks_outlined,
              size: 25.sp,
            ),
            label: 'Bookmarks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_3_outlined, size: 25.sp),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
