import 'package:blog_app/Common_Widget/snackbar.dart';
import 'package:blog_app/Helpre_Classh/Provider/BookMarks/bookmarks_provider.dart';
import 'package:blog_app/Helpre_Classh/Provider/Comment/get_comment_provider.dart';
import 'package:blog_app/Helpre_Classh/Provider/Details/details_provider.dart';
import 'package:blog_app/Helpre_Classh/Provider/Like/like_provider.dart';
import 'package:blog_app/Helpre_Classh/api/Single_Blog/single_blog_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bookmarks_item.dart';
import 'package:blog_app/App_UI/Blog_Details/blog_details.dart';

class BookmarksBody extends StatelessWidget {

  const BookmarksBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Expanded(
            child: Consumer<BookmarksProvider>(
              builder: (context, provider ,  child){
                final bookmarks = provider.bookmarksBlog;
                return bookmarks.isEmpty ? 
                Center(child: Text('No Blog in your bookmarks', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),),) :
                ListView.builder(
                itemCount: bookmarks.length,
                itemBuilder: (context, index) {
                  final item = bookmarks[index];
                  return BookmarksItem(
                    title: item['title'],
                    decoration: item['content'],
                    imagePath: item['image'],
                    onTap: () async{
                      try{
                      showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                    final response = await fetchSingleBlog(item['id']);
                    await context.read<GetCommentProvider>().getComment(item['id']);
                    await context.read<LikeProvider>().getLikeCount(item['id']);
                    await context.read<LikeProvider>().getUserLike();
                    await context.read<BookmarksProvider>().inBookmark(item['id']);
                    Navigator.pop(context);
                    if (response != null && response.success) {
                      context.read<DetailsProvider>().singleBlog(
                        response,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BlogDetails(),
                        ),
                      );
                    } else {
                      showSnackBarMessage(
                        context,
                        'Somtheing went wrong',
                      );
                    }
                    }catch(e){
                    Navigator.pop(context);
                    showSnackBarMessage(context, 'Error: $e');
                    }
                    },
                  );
                },
              ); 
              }
            ),
          ),
        ],
      ),
    );
  }
}
