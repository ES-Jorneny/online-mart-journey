import 'package:flutter/material.dart';
import 'package:online_mart_journey_app/utils/app_constants.dart';

class HeadingWidget extends StatelessWidget {
  final String headingTitle;
  final String headingSubtitle;
  final VoidCallback onTap;
  final String buttonText;
  const HeadingWidget({super.key, required this.headingTitle, required this.headingSubtitle, required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(headingTitle,style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800
            ),),
            Text(headingSubtitle,style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Colors.grey
            ),),

          ],
        ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: appMainColor,
                width: 1.5,
              )
            ),
            child: Text(buttonText,style: TextStyle(
              color: appMainColor,
              fontWeight: FontWeight.w500,
              fontSize: 12
            ),),),
          )
        ],
      ),
    );
  }
}
