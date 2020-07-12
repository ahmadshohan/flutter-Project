import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class ProjektListView extends StatelessWidget {
  final projektData;

  ProjektListView(this.projektData);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (ctx, i) => Container(
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              projektData['data']['real_estates'][i]['iamge'],
            ),
          ),
        ),
        child: Container(
          width: 330,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 10, top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Container(
                          height: 70,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20),
                                top: Radius.circular(2)),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              projektData['data']['real_estates'][i]['price'],
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                " ${projektData['data']['real_estates'][i]['city']}"
                                '-',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  projektData['data']['real_estates'][i]
                                      ['municipality'],
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          kSizedBoxWidth10,
                          CircleAvatar(
                            backgroundColor: Color(0xFF565661),
                            child: Image.asset(
                              'images/plac.png',
                              height: 25,
                              width: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Text(
                    projektData['data']['real_estates'][i]['title'],
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ),
                Text(
                  projektData['data']['real_estates'][i]['description'],
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                kSizedBoxHight5,
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    textColor: Colors.black,
                    color: const Color(0xFFFFD424),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: const Text(
                        'مشاهدة',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    onPressed: () {
                      showErrorDialog('No thing now', context);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
