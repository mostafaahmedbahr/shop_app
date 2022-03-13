import 'package:flutter/material.dart';
import 'package:shop_app_final/core/utils/nav.dart';
import 'package:shop_app_final/dio/sp_helper/cache_helper.dart';
import 'package:shop_app_final/modules/login/login.dart';
  import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  final String image;
  final String text;
  final String body;

  BoardingModel({
    required this.text,
    required this.image,
    required this.body,
  });
}
class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        text: "screen 1",
        image: "assets/images/img.png",
        body: "body 1 ",
    ),
    BoardingModel(
      text: "screen ",
      image: "assets/images/img2.jpg",
      body: "body  ",
    ),
    BoardingModel(
      text: "screen 3",
      image: "assets/images/img3.jpg",
      body: "body 3 ",
    ),
  ];

  var boardingCon = PageController();
  bool isLast = false;

  void submit()
  {
    SharedPreferencesHelper.saveData(
        key: "OnBoardingScreen", value: true,
    ).then((value)
    {
      if(value)
      {
        AppNav.customNavigator(
          context: context,
          screen: ShopLoginScreen(),
          finish: false,
        );
      }
     }).catchError((error)
    {
      print("sharedpre saveData error${error.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          TextButton(onPressed:submit,
              child: Text("SKIP"),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index)
                {
                  if(index == boarding.length-1)
                  {
                    setState(() {
                      isLast = true;
                    });
                    print("last paage");
                  }
                  else
                  {
                    setState(() {
                      isLast = false;
                    });
                    print("not");
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardingCon,
                  itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingCon,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.deepOrange,
                    ),
                    count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                   setState(() {
                     if(isLast)
                     {
                       submit();
                     }
                     else
                     {
                       boardingCon.nextPage(
                         duration: Duration(seconds: 2),
                         curve: Curves.easeInOutCubicEmphasized,
                       );
                     }
                   });
                  },
                  child: Icon(Icons.arrow_forward_ios),
                  backgroundColor: Colors.deepOrange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(image: AssetImage(model.image),
        ),
      ),
      SizedBox(height: 30,),
      Text(model.text,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),),
      SizedBox(height: 15,),
      Text(model.body,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),),
    ],
  );
}
