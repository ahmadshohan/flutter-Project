import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/slide_item.dart';
import '../widgets/projekt_horizontal_list.dart';
import '../widgets/news_events_Vertical_list.dart';
import '../widgets/services_horizontal_List.dart';
import '../widgets/slide_dots.dart';
import '../constants.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  final homeData;
  HomeScreen(this.homeData);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentImage = 0;
  final PageController _imageController = PageController(initialPage: 0);
  @override
  void dispose() {
    super.dispose();
    _imageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentImage < 4) {
        _currentImage++;
      } else {
        _currentImage = 0;
      }
      _imageController.animateToPage(_currentImage,
          duration: Duration(milliseconds: 300), curve: Curves.easeInToLinear);
    });
  }

  _onImageChanged(int index) {
    setState(() {
      _currentImage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var allData = widget.homeData;
    double hight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(children: <Widget>[
        Container(
          height: hight * 0.4,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              PageView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                controller: _imageController,
                onPageChanged: _onImageChanged,
                itemBuilder: (ctx, i) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          NetworkImage(allData['data']['sliders'][i]['iamge']),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 60, left: 30),
                        child: Image.asset(
                          'images/hmbrger.png',
                          width: 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 130,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Image.asset(
                          'images/daarlogo.png',
                          width: 60,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      for (int i = 0; i < 4; i++)
                        if (i == _currentImage)
                          SlideDots(true)
                        else
                          SlideDots(false)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Card(
                    elevation: 7,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'خدماتنا',
                              style: TextStyle(
                                color: Color(0xFF3C3C3C),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text(
                              'اختر الخدمة التي تتناسب مع احتياجاتك',
                              style: TextStyle(
                                color: const Color(0xFF3C3C3C),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          ServicesHorizontalList(allData: allData),
                        ],
                      ),
                    ),
                  ),
                  kSizedBoxHight5,
                  Image.asset('images/gb.png'),
                  Padding(
                    padding: const EdgeInsets.only(right: 13),
                    child: Text(
                      "المشاريع",
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF3C3C3C)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 17),
                    child: Text(
                      "يمكنك استعراض اخر المشاريع من هنا",
                      style: const TextStyle(
                          fontSize: 17,
                          color: const Color(0xFF3C3C3C),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4, top: 10),
                    child:
                        Container(height: 280, child: ProjektListView(allData)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 13),
                    child: Text(
                      "اخر الأخبار",
                      style: TextStyle(fontSize: 22, color: Color(0xFF3C3C3C)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 17),
                    child: Text(
                      "من هنا يمكنك استعراض اخر الاخبار",
                      style: const TextStyle(
                          fontSize: 17,
                          color: Color(0xFF3C3C3C),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Container(
                        height: 200,
                        child: NewsEventsVerticalList(allData: allData)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 30),
                    child: Image.asset('images/gb.png'),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
    ));
  }
}
