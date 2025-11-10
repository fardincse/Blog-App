import 'package:blog_app/Helpre_Classh/Provider/bookmarks_provider.dart';
import 'package:blog_app/Helpre_Classh/Provider/details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:blog_app/App_UI/Blog_Details/comments.dart';
import 'package:blog_app/Common_Widget/text_from_filed.dart';
import 'package:blog_app/Common_Widget/snackbar.dart';

class BlogDetails extends StatefulWidget {
  const BlogDetails({super.key});

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  final List<Map<String, dynamic>> _comments = [
    {
      'image': 'assets/images/profile4.png',
      'name': 'Lima Walker',
      'ago': '2d',
      'comment':
          'Great article! I\'m particularly interested in the section on renewable energy. Do you have any recommendations for further reading on the topic?',
    },
    {
      'image': 'assets/images/profile3.png',
      'name': 'Ethan Carter',
      'ago': '1d',
      'comment':
          'Thanks for your feedback, Liam! I\'d recommend checking out the latest reports from the International Renewable Energy Agency (IRENA) for comprehensive data and insights.',
    },
    {
      'image': 'assets/images/profile2.png',
      'name': 'Henry Walker',
      'ago': '15h',
      'comment':
          'Great article! I\'m particularly interested in the section on renewable energy. Do you have any recommendations for further reading on the topic?',
    },
    {
      'image': 'assets/images/profile1.png',
      'name': 'Sophia Carter',
      'ago': '6h',
      'comment':
          'Thanks for your feedback, Liam! I\'d recommend checking out the latest reports from the International Renewable Energy Agency (IRENA) for comprehensive data and insights.',
    },
  ];

  final TextEditingController _commentController = TextEditingController();
  bool _inLove = false;
  int _love = 123;

  @override
  Widget build(BuildContext context) {
    bool inBookmark = context.watch<BookmarksProvider>().inBookmark({
      'title': context.read<DetailsProvider>().title,
      'image': context.read<DetailsProvider>().imagePath,
    });
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, size: 25.sp, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              !inBookmark
                  ? {
                      context.read<BookmarksProvider>().addTOBookmarks({
                        'title': context.read<DetailsProvider>().title,
                        'image': context.read<DetailsProvider>().imagePath,
                      }),
                      showSnackBarMessage(context, 'Blog add to Bookmarks'),
                    }
                  : {
                      context.read<BookmarksProvider>().removeFromBookmarks({
                        'title': context.read<DetailsProvider>().title,
                        'image': context.read<DetailsProvider>().imagePath,
                      }),
                      showSnackBarMessage(
                        context,
                        'Blog remove from Bookmarks',
                      ),
                    };
            },
            icon: Icon(
              inBookmark ? Icons.bookmark : Icons.bookmark_border_outlined,
              size: 25.sp,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 320.h,
              width: 390.w,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white),
              child: Image.asset(
                context.read<DetailsProvider>().imagePath,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    context.read<DetailsProvider>().title,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 28.r,
                          backgroundImage: AssetImage(
                            'assets/images/profile5.png',
                          ),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Author',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Olivia Harper',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xFF9EA6BA),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'In a world increasingly aware of its environmental footprint, the concept of sustainable living has moved from a niche lifestyle to a mainstream necessity. This article explores the innovative approaches and technologies that are shaping a greener future, from renewable energy solutions to eco-friendly consumer products.',
                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _inLove = !_inLove;
                            _inLove ? _love = _love + 1 : _love = _love - 1;
                          });
                        },
                        icon: Icon(
                          _inLove ? Icons.favorite : Icons.favorite_border,
                          color: _inLove ? Colors.pink[700] : Color(0xFF9EA6BA),
                          size: 25.sp,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '$_love',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF9EA6BA),
                        ),
                      ),
                      SizedBox(width: 30),
                      Icon(
                        Icons.comment,
                        color: Color(0xFF9EA6BA),
                        size: 25.sp,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '45',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF9EA6BA),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Comments',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: _comments.length,
                    itemBuilder: (context, index) {
                      final comment = _comments[index];
                      return Comments(
                        imagePath: comment['image'],
                        name: comment['name'],
                        ago: comment['ago'],
                        comment: comment['comment'],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 70.h,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundImage: AssetImage('assets/images/profile5.png'),
              backgroundColor: Colors.grey,
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextInputFiled(
                controller: _commentController,
                inputFormatters: [LengthLimitingTextInputFormatter(250)],
                hintText: 'Write a comment...',
                keyBoardType: TextInputType.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
