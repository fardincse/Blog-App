import 'package:blog_app/Common_Widget/snackbar.dart';
import 'package:blog_app/Helpre_Classh/Provider/BookMarks/bookmarks_provider.dart';
import 'package:blog_app/Helpre_Classh/Provider/Comment/get_comment_provider.dart';
import 'package:blog_app/Helpre_Classh/Provider/Like/like_provider.dart';
import 'package:blog_app/Helpre_Classh/Provider/Usre_Provider/user_provider.dart';
import 'package:blog_app/Helpre_Classh/Provider/Details/details_provider.dart';
import 'package:blog_app/Model/Like/get_user_like_model.dart';
import 'package:blog_app/Utils/Comment/edit_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:blog_app/App_UI/Blog_Details/comments.dart';
import 'package:blog_app/Common_Widget/text_from_filed.dart';
import 'package:blog_app/Utils/Time_Formate/time_model.dart';
import 'package:blog_app/Utils/Comment/delete_coment.dart';
import 'package:blog_app/App_UI/Auth/Profile/profile.dart';

class BlogDetails extends StatefulWidget {
  const BlogDetails({super.key});

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  final TextEditingController _commentController = TextEditingController();

  bool isLike = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final blog = context.read<DetailsProvider>().blog!.data!.post!;
      final likeProvider = context.read<LikeProvider>();

      List<Posts>? userLike = likeProvider.userLike?.data?.posts;

      if (userLike != null) {
        isLike = userLike.any((ele) => ele.id == blog.id.toString());
      } else {
        isLike = likeProvider.postLike?.data?.liked ?? false;
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final details = context.read<DetailsProvider>().blog;
    final bookmark = context.watch<BookmarksProvider>().isbookmarks;
    if (details!.data!.post == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final blog = details.data!.post!;
    final comments = context.watch<GetCommentProvider>().allComent;
    if (comments == null || comments.data == null) {
      return Center(child: CircularProgressIndicator());
    }
    final commentList = comments.data!.comments!;
    final like = context.watch<LikeProvider>().likeCount;
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
              bookmark
                  ? {
                      context.read<BookmarksProvider>().removeFromBookmarks(blog.id!),
                      showSnackBarMessage(
                        context,
                        'Blog remove from Bookmarks',
                      ),
                    }
                  : {
                      context.read<BookmarksProvider>().addTOBookmarks({
                        'id' : blog.id,
                        'title': blog.title,
                        'content' : blog.content,
                        'image': blog.featuredImage,
                      }),
                      showSnackBarMessage(context, 'Blog add to Bookmarks'),
                    };
            },
            icon: Icon(
              bookmark! ? Icons.bookmark :
              Icons.bookmark_border_outlined,
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
              child: Image.network(
                blog.featuredImage ?? '',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Image(
                  image: AssetImage('assets/images/no-image-found.jpg'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    blog.title!,
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
                          backgroundImage: NetworkImage(blog.author!.avatar!),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Author',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                timeAgo(blog.createdAt!),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xFF9EA6BA),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            blog.author!.name!,
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
                    blog.content!,
                    style: TextStyle(fontSize: 14.sp, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isLike = !isLike;
                          });
                          context.read<LikeProvider>().likeBlog(blog.id!);
                        },
                        icon: Icon(
                          isLike ? Icons.favorite : Icons.favorite_border,
                          color: isLike ? Colors.pink[700] : Color(0xFF9EA6BA),
                          size: 25.sp,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '${like!.data!.totalLikes}',
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
                        '${comments.data!.comments!.length}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF9EA6BA),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profile()),
                          );
                        },
                        child: CircleAvatar(
                          radius: 20.r,
                          backgroundImage: AssetImage(
                            context.read<UserProvider>().userProfile,
                          ),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextInputFiled(
                          controller: _commentController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(250),
                          ],
                          hintText: 'Write a comment...',
                          keyBoardType: TextInputType.text,
                          maxLine: 3,
                          suffixIcon: IconButton(
                            onPressed: () async {
                              if (_commentController.text.isEmpty) {
                                showSnackBarMessage(
                                  context,
                                  "Write a commrnt please",
                                );
                              } else {
                                context
                                    .read<GetCommentProvider>()
                                    .addAndRefreshComment(
                                      blog.id!,
                                      _commentController.text,
                                    );
                                _commentController.clear();
                                final response = context
                                    .read<GetCommentProvider>()
                                    .message;
                                showSnackBarMessage(context, response!);
                              }
                            },
                            icon: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 25.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Comments',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  (comments.data == null)
                      ? SizedBox.shrink()
                      : ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: commentList.length,
                          itemBuilder: (context, index) {
                            final comment = comments.data!.comments![index];
                            final commenterId = comment.author!.id;
                            final userId = context
                                .read<UserProvider>()
                                .user!
                                .data!
                                .user!
                                .id;
                            return Comments(
                              imagePath: comment.author!.avatar!,
                              name: comment.author!.name!,
                              ago: timeAgo(comment.createdAt!),
                              comment: comment.content!,
                              onLongPress: () {
                                if (commenterId == userId) {
                                  showCommentOptionsDialog(
                                    context,
                                    comment.id!,
                                    comment.content!,
                                    () {
                                      showEditCommentDialog(
                                        context,
                                        comment.content!,
                                        (editedText) {
                                          context
                                              .read<GetCommentProvider>()
                                              .editAndRefreshComment(
                                                comment.id!,
                                                editedText,
                                                blog.id!,
                                              );
                                          showSnackBarMessage(
                                            context,
                                            context
                                                .read<GetCommentProvider>()
                                                .editMessage!,
                                          );
                                        },
                                      );
                                      print(comment.content);
                                    },
                                    () {
                                      context
                                          .read<GetCommentProvider>()
                                          .deleteAndRefreshComment(
                                            comment.id!,
                                            blog.id!,
                                          );
                                      final response = context
                                          .read<GetCommentProvider>()
                                          .deleteMessage;
                                      showSnackBarMessage(context, response!);
                                    },
                                  );
                                }
                              },
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
