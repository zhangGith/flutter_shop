import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText = '欢迎你来到美好人才';

 Future _getHttp() async {
   try {
     print("数据。。。。");
     Dio dio = Dio();
        //  response = await Dio().get('https://api.github.com/orgs/flutterchina/repos');
     List response;
      response = await [
        {'image' : 'https://p.pstatp.com/origin/1385e000086d036fdcb1'},
        {'image' : 'https://www.soumeitu.com/wp-content/uploads/2020/07/NTE5NjU5MTA1NDI3NzE2NTc0M18xNTk0Mzc5OTExMjI0_6.jpg'},
        {'image' : 'https://p.pstatp.com/origin/1379e0000949529d04b29'},
        {'image' : 'https://xintp.betcsm.com/c2020/11/06/4jg0waybhgt.jpg'},
        {'image' : 'https://img.soumeitu.com/wp-content/uploads/2020/07/NTE5NjU5MTA1NDI3NzE2NTc0M18xNTk0Mzc5OTExMjI0_4.jpg?imageView2/0/q/100'},
      ];
     return response;
   } catch (e) {
     print('==========>${e}');
   } 
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('美好人间'),),
      body: FutureBuilder(
        future: _getHttp(),
        builder: (context,snaphot) {
          print('===========------->${snaphot.data}');
          if (snaphot.hasData) {
            var data = json.decode(snaphot.data.toString());
            return Column(
              children: <Widget>[
                SwiperDiy()
              ],
            );
          } else {
            return Center(
                child: Text('加载中'),
            );
          }
        }
      ),
    );
  }
}

//********************************** */

class SwiperDiy extends StatelessWidget {

  final List swiperItems;

  SwiperDiy({Key? key, required this.swiperItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemCount: swiperItems.length,
        itemBuilder: (context, index) {
          return Image.network("${swiperItems[index]['image']}", fit: BoxFit.fitHeight,);
        },
        pagination: SwiperPagination(),
        autoplay: true,
        ),
    );
  }
}

class TopNavigator extends StatelessWidget {

  final List navList;
  TopNavigator({Key? key, required this.navList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () => print('点击导航'),
      child: Column(
        children: [
          Image.network(item['image'], width: ScreenUtil().setWidth(95));
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(4.0),
        children: navList.map((e) => _gridViewItemUI(context, e)).toList(),
        ),
    );
  }
}


// //广告图片
class AdBanner extends StatelessWidget {
  final String advertesPicture;

  AdBanner({Key? key, required this.advertesPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(advertesPicture),
    );
  }
}

class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  LeaderPhone({required Key key, required this.leaderImage, required this.leaderPhone}) : super(key: key);

  Future<void> _openUrl() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not lauch url';
    }}
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _openUrl,
        child: Image.network(leaderImage),
      ),
    );
  }
}