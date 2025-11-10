import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Blog/blog_appbar.dart';
import 'Blog/blog_body.dart';
import 'Bookmarks/bookmarks_appbar.dart';
import 'Bookmarks/bookmarks_body.dart';
import '../Profile/profile.dart';

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
                  onPressed: () {},
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
        onTap: (index) {
          if (index < 2) {
            setState(() {
              _currentIndex = index;
            });
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
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
