import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostCardView extends StatelessWidget {
  const PostCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  'https://i.pinimg.com/originals/45/8c/ef/458cef766d53e9054ca952b4b87f2f85.jpg',
                ),
              ),
              title: Row(
                children: [
                  Text(
                    'User Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '3h',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                    size: 15,
                  ),
                ],
              ),
              subtitle: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing el it,',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.w, left: 70.w),
              child: Image.network(
                'https://i.pinimg.com/originals/45/8c/ef/458cef766d53e9054ca952b4b87f2f85.jpg',
                height: 250.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.w, left: 70.w, top: 10.h),
              child: const Row(
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 20,
                  ),
                  SizedBox(width: 20),
                  Icon(
                    Icons.chat_bubble_rounded,
                    size: 20,
                  ),
                  SizedBox(width: 20),
                  Icon(
                    Icons.cached_rounded,
                    size: 20,
                  ),
                  SizedBox(width: 20),
                  Icon(
                    Icons.send_rounded,
                    size: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.w, left: 70.w, top: 10.h),
              child: const Row(
                children: [
                  Text(
                    '1000 repplies . 1000 likes . 1000 shares',
                  ),
                ],
              ),
            ),
            const Divider(),
          ],
        ),
        // Positioned(
        //   left: 35.w,
        //   top: 63.h,
        //   child: Container(
        //     width: 3,
        //     height: 300.h,
        //     color: Colors.grey[300],
        //   ),
        // ),
      ],
    );
  }
}
