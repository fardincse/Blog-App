import 'package:blog_app/App_UI/Blog_Details/blog_details.dart';
import 'package:blog_app/Common_Widget/blog_item.dart';
import 'package:blog_app/Common_Widget/snackbar.dart';
import 'package:blog_app/Helpre_Classh/Provider/Comment/get_comment_provider.dart';
import 'package:blog_app/Helpre_Classh/Provider/Details/details_provider.dart';
import 'package:blog_app/Helpre_Classh/Provider/Like/like_provider.dart';
import 'package:blog_app/Helpre_Classh/api/Search/search_api.dart';
import 'package:blog_app/Helpre_Classh/api/Single_Blog/single_blog_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blog_app/Common_Widget/text_from_filed.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget{
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{

  final TextEditingController _searchController = TextEditingController();

  List searchfound = []; 
  bool isSearch = false;
  bool isLoading = false;     


  Future<void> performSearch() async {
    if (_searchController.text.isEmpty) {
      setState(() {
        isSearch = false;
        searchfound.clear();
      });
      return;
    }

    setState(() {
      isSearch = true;
      isLoading = true;    
    });

    final res = await searchBlog(_searchController.text);

    setState(() {
      isLoading = false; 
    });

    if (res.success == true) {
      setState(() {
        searchfound = res.data.posts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.transparent,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, size: 25.sp, color: Colors.white),
        ),

        title: TextInputFiled(
          controller: _searchController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
            LengthLimitingTextInputFormatter(50),
          ],
          hintText: 'Search blog',
          keyBoardType: TextInputType.text,
          prefixIcon: IconButton(
            onPressed: performSearch,
            icon: Icon(Icons.search, size: 25.sp, color: Color(0xFF9EA6BA)),
          ),
        ),

        actions: [
          IconButton(
            onPressed: performSearch,   
            icon: Icon(Icons.search, size: 30.sp, color: Colors.white),
          )
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),

        child: isLoading
            ? const Center(  
                child: CircularProgressIndicator(color: Colors.white),
              )
            : isSearch == false
                ? Center(
                    child: Text(
                      "Search something...",
                      style: TextStyle(color: Colors.white54, fontSize: 18.sp),
                    ),
                  )
                : searchfound.isEmpty
                    ? Center(
                        child: Text(
                          "No results found",
                          style: TextStyle(color: Colors.white54, fontSize: 18.sp),
                        ),
                      )

                    : ListView.builder(
                        itemCount: searchfound.length,
                        itemBuilder: (context, index) {
                          final blog = searchfound[index];

                          return BlogItem(
                            cetagory: blog.categories.isNotEmpty
                                ? blog.categories.first
                                : 'Uncategorized',
                            title: blog.title ?? 'Untitled',
                            decoration: blog.content ?? '',
                            imagePath: blog.featuredImage ?? '',

                            onTap: () async {
                              try {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                );

                                final response =
                                    await fetchSingleBlog(blog.id!);

                                await context
                                    .read<GetCommentProvider>()
                                    .getComment(blog.id!);

                                await context
                                    .read<LikeProvider>()
                                    .getLikeCount(blog.id!);

                                await context
                                    .read<LikeProvider>()
                                    .getUserLike();

                                Navigator.pop(context);

                                if (response != null && response.success) {
                                  context
                                      .read<DetailsProvider>()
                                      .singleBlog(response);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const BlogDetails(),
                                    ),
                                  );
                                } else {
                                  showSnackBarMessage(
                                      context, 'Something went wrong');
                                }
                              } catch (e) {
                                Navigator.pop(context);
                                showSnackBarMessage(context, 'Error: $e');
                              }
                            },
                          );
                        },
                      ),
      ),
    );
  }
}
