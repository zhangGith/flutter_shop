import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
     print('111111111111111111111111111');
  }


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
                String floor1Title =data['data']['floor1Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
                String floor2Title =data['data']['floor2Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
                String floor3Title =data['data']['floor3Pic']['PICTURE_ADDRESS'];//楼层1的标题图片
                List<Map> floor1 = (data['data']['floor1'] as List).cast(); //楼层1商品和图片 
                List<Map> floor2 = (data['data']['floor2'] as List).cast(); //楼层1商品和图片 
                List<Map> floor3 = (data['data']['floor3'] as List).cast(); //楼层1商品和图片 

            return SingleChildScrollView(
              child: Column(
              children: <Widget>[
                SwiperDiy(swiperItems: [],),
                TopNavigator(navList: [],),
                AdBanner(advertesPicture: '',),
                LeaderPhone(leaderImage: '', leaderPhone: '',),
                Recommend(recommendList: [],),
                FloorTitle(pic_address: floor1Title,),
                FloorContent(list: floor1),
                FloorTitle(pic_address: floor2Title,),
                FloorContent(list: floor2),
                FloorTitle(pic_address: floor3Title,),
                FloorContent(list: floor3),
              ],
            )
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

class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('数据加载中。。。');
  }

  // //火爆专区标题
  Widget hotTitle =  Container(
    margin: EdgeInsets.only(top: 10.0),
    padding: EdgeInsets.all(5.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(width: 0.5, color: Colors.black12),
      ),
    ),
    child: Text('火爆专区'),
  );

  //火爆专区子项
   List<Map> hotGoodsList = [];
  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((e) {
        return InkWell(
          onTap: () { print("点击了火爆商品");},
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(e['image'], width: ScreenUtil().setWidth(375),),
                Text(
                  e['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: [
                    Text('¥${e['mallPrice']}'),
                    Text(
                      '¥${e['price']}',
                      style: TextStyle(color: Colors.black26, decoration: TextDecoration.lineThrough),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
    
  }

//火爆专区组合
  Widget _hotGoods(){
    return Container(
      child: Column(
        children: [
          hotTitle,
          _wrapList(),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return _hotGoods();
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

  LeaderPhone({Key? key, required this.leaderImage, required this.leaderPhone}) : super(key: key);

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

//商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({Key? key, required this.recommendList}) : super(key: key);

  //推荐商品标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black12),
        ),
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(left: BorderSide(width: 0.5, color: Colors.black12)),
        ),
        child: Column(
          children: [
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(330),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(context);
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          _titleWidget(),
          _recommendList(),
        ],
      ),
    );
  }
}

class FloorTitle extends StatelessWidget {

  final String pic_address;
  FloorTitle({Key? key, required this.pic_address}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(this.pic_address),
    );
  }
}

class FloorContent extends StatelessWidget {
  final List list;
  FloorContent({Key? key, required this.list}) : super(key: key);

  Widget _goodsItem(Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () => print('点击了楼层商品'),
        child: Image.network(goods['image']),
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: [
        _goodsItem(this.list[0]),
        Column(
          children: [
            _goodsItem(this.list[1]),
            _goodsItem(this.list[2]),
          ]
        )
      ],
    );
  }

  Widget _otherGoods() {
    return Row(
      children: [
            _goodsItem(this.list[3]),
            _goodsItem(this.list[4]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _firstRow(),
          _otherGoods(),
        ]
      ),
    );
  }
}