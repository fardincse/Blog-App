import 'package:blog_app/Common_Widget/snackbar.dart';
import 'package:blog_app/Helpre_Classh/Provider/BookMarks/bookmarks_provider.dart';
import 'package:blog_app/Helpre_Classh/Provider/Comment/get_comment_provider.dart';
import 'package:blog_app/Helpre_Classh/Provider/Like/like_provider.dart';
import 'package:blog_app/Helpre_Classh/Provider/Blog/blog_provider.dart';
import 'package:blog_app/Helpre_Classh/Provider/Details/details_provider.dart';
import 'package:blog_app/Helpre_Classh/api/Single_Blog/single_blog_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blog_app/Common_Widget/blog_item.dart';
import 'package:blog_app/App_UI/Blog_Details/blog_details.dart';


class BlogBody extends StatelessWidget {
  const BlogBody({super.key});

  @override
  Widget build(BuildContext context) {
    final blogProvider = context.read<BlogProvider>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: FutureBuilder(
        future: blogProvider.addBlogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData && snapshot.data != null) {
            final response = snapshot.data!;
            final posts = response.posts ?? [];
      
            if (posts.isEmpty) {
              return const Center(child: Text('No blogs available.'));
            }
      
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final item = posts[index];
                return BlogItem(
                  cetagory: (item.categories?.isNotEmpty == true)
                      ? item.categories!.first
                      : 'Uncategorized',
                  title: item.title ?? 'Untitled',
                  decoration: item.content ?? '',
                  imagePath: item.featuredImage ?? '',
                  onTap: () async {
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
                    final response = await fetchSingleBlog(item.id!);
                    await context.read<GetCommentProvider>().getComment(item.id!);
                    await context.read<LikeProvider>().getLikeCount(item.id!);
                    await context.read<LikeProvider>().getUserLike();
                    await context.read<BookmarksProvider>().inBookmark(item.id!);
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
          return const Center(child: Text('Something went wrong.'));
        },
      ),
    );
  }
}
