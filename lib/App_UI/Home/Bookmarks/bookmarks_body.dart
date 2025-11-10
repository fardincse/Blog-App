import 'package:blog_app/Helpre_Classh/Provider/bookmarks_provider.dart';
import 'package:blog_app/Helpre_Classh/Provider/details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blog_app/Common_Widget/text_from_filed.dart';
import 'bookmarks_item.dart';
import 'package:blog_app/App_UI/Blog_Details/blog_details.dart';

class BookmarksBody extends StatelessWidget {

  final TextEditingController _searchController = TextEditingController();

  BookmarksBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            TextInputFiled(
              controller: _searchController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                LengthLimitingTextInputFormatter(50),
              ],
              hintText: 'Search bookmarks',
              keyBoardType: TextInputType.text,
              prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.search, size: 25.sp, color: Color(0xFF9EA6BA)),
              ),
            ),
            SizedBox(height: 20),
            Consumer<BookmarksProvider>(
              builder: (context, provider ,  child){
                final bookmarks = provider.bookmarksBlog;
                return ListView.builder(
                shrinkWrap: true,
                itemCount: bookmarks.length,
                itemBuilder: (context, index) {
                  final item = bookmarks[index];
                  return BookmarksItem(
                    title: item['title'],
                    decoration:
                        'This is blog descreption max line 3 jifdsvzkj bjfdngksd dsvnkjdvi vdsnvbjdio dihvaibn vdhiegn vnvjgv vh  b j nerjb v ninermlkfm eeiorebmkl  mef',
                    imagePath: item['image'],
                    onTap: (){
                      context.read<DetailsProvider>().details(item['title'], item['image']);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetails()));
                    },
                  );
                },
              ); 
              }
            ),
          ],
        ),
      ),
    );
  }
}
