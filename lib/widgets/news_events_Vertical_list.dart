import 'package:flutter/material.dart';

class NewsEventsVerticalList extends StatelessWidget {
  const NewsEventsVerticalList({
    Key key,
    @required this.allData,
  }) : super(key: key);

  final allData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      scrollDirection: Axis.vertical,
      itemCount: 5,
      itemBuilder: (ctx, i) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                  Text(
                    allData['data']['sevices'][i]['title'],
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF3C3C3C)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      allData['data']['sevices'][i]['description'],
                      maxLines: 2,
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Color(0xFF3C3C3C), fontSize: 14),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
//                                                "${DateFormat('EEEE').format(today)}"
//                                                "${DateFormat(' d, MMMM yyyy').format(today)}",
                        'الخميس 10 نوفمبر  2017',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF3C3C3C),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset(
                        'images/school-calendar.png',
                        height: 40,
                        width: 25,
                      ),
                    ],
                  )
                ]),
              ),
              SizedBox(width: 10,),
              Expanded(
                flex: 1,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        allData['data']['sevices'][i]['iamge'],
                        fit: BoxFit.contain)),
              )
            ]),
          )),
    );
  }
}
