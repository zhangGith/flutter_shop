import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();
  String showText = '欢迎你来到美好人才';

  //  void _choiceAction(){
  //   print('开始选择你喜欢的类型............');
  //   if(typeController.text.toString()==''){
  //     showDialog(
  //       context: context,
  //       builder: (context)=>AlertDialog(title:Text('美女类型不能为空'))
  //     );
  //   }else{
  //       getHttp(typeController.text.toString()).then((val){
  //        setState(() {
  //          showText=val['data']['name'].toString();
  //        });
  //       });
  //   }

  // }

  void _choiceAction() {
    print('.........');
    if (typeController.text.toString() == '') {
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(title: Text('美女类型不能为空'))
      );
    } else {
      getHttp(typeController.text.toString()).then((value) {
        setState(() {
          showText = value['data']['name'].toString();
        });
      });
    }
  }

  Future getHttp(String typeText) async {
    try {
      Response response;
      var data = {'name' : typeText};
      response = await Dio().get(
        '',
        queryParameters: data,
      );
      return response.data;
    } catch (e) {
      return print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('美好人间'),),
      body:Container(
        height: 1000,
        child: Column(
          children:[
            TextField(
              controller: typeController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                labelText: '美女类型',
                helperText: '请输入你喜欢的类型',
                ), 
                autofocus: false,
            ),
            RaisedButton(
              onPressed: null,
              child: Text('选择完毕'),
              ),

              Text(
                showText,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
          ],
        ),
      )
    );
  }
}