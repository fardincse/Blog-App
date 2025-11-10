import 'package:blog_app/Helpre_Classh/Provider/details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_app/Common_Widget/blog_item.dart';
import 'package:blog_app/App_UI/Blog_Details/blog_details.dart';

class BlogBody extends StatelessWidget {
  final List<Map<String, dynamic>> image = [
    {
      'title' : 'Mastering User Interface Design Principles',
      'image' : 'assets/images/Frame2.png'},
    {
      'title' : 'Time Management Techniques for Professionals',
      'image' : 'assets/images/Frame3.png'},
    {
      'title' : 'The Future of AI in Software Development',
      'image' : 'assets/images/Frame4.png'},
    {
      'title' : 'Mastering User Interface Design Principles',
      'image' : 'assets/images/Frame5.png'},
    {
      'title' : 'Time Management Techniques for Professionals',
      'image' : 'assets/images/Frame6.png'},
    {
      'title' : 'Building a Strong Professional Network',
      'image' : 'assets/images/Frame7.png'},
    {
      'title' : 'SEO Strategies for Beginners',
      'image' : 'assets/images/Frame8.png'},
    {
      'title' : 'Web Design Trends 2024',
      'image' : 'assets/images/Frame9.png'},
  ];

  BlogBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
        itemCount: image.length,
        itemBuilder: (context, index) {
          final item = image[index];
          return BlogItem(
            cetagory: 'cetagory',
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
      ),
    );
  }
}
