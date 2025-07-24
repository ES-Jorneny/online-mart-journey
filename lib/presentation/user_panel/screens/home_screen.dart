import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online_mart_journey_app/presentation/user_panel/widgets/all_product_widgets.dart';
import 'package:online_mart_journey_app/presentation/user_panel/widgets/banner_widget.dart';
import 'package:online_mart_journey_app/presentation/user_panel/widgets/category_widget.dart';
import 'package:online_mart_journey_app/presentation/user_panel/widgets/custom_drawer_widget.dart';
import 'package:online_mart_journey_app/presentation/user_panel/widgets/flash_sale_widget.dart';
import 'package:online_mart_journey_app/presentation/user_panel/widgets/heading_widget.dart';
import '../../../utils/app_constants.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: appMainColor,
            statusBarBrightness: Brightness.light
        ),
        backgroundColor: appMainColor,
        title: Text(appMainName,style: TextStyle(
            color: appTextColor
        ),),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          child: Column(
            children: [
              SizedBox(
                height: Get.height/70.0,
              ),
              // banners
              BannerWidget(),
              // heading widget
             HeadingWidget(
               headingTitle: "Categories",
               headingSubtitle: "According to your budget",
               buttonText: "See more >",
               onTap: (){
              Get.toNamed("/allCategories");
               },
             ),
              CategoryWidget(),
              HeadingWidget(
                headingTitle: "Flash Sale",
                headingSubtitle: "According to your budget",
                buttonText: "See more >",
                onTap: (){
              Get.toNamed("/allFlashProducts");
                },
              ),
              FlashSaleWidget(),
              HeadingWidget(
                headingTitle: "All Products",
                headingSubtitle: "According to your budget",
                buttonText: "See more >",
                onTap: (){
              Get.toNamed("/allProducts");
                },
              ),
              AllProductWidgets()

            ],
          ),
        ),
      )
    );
  }
}
