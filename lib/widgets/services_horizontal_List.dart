import 'package:flutter/material.dart';

class ServicesHorizontalList extends StatelessWidget {
  const ServicesHorizontalList({
    Key key,
    @required this.allData,
  }) : super(key: key);

  final allData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        reverse: true,
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, i) => Expanded(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  allData['data']['news_and_events'][i]['iamge'],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  allData["data"]["news_and_events"][i]['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
