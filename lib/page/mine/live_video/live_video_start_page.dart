
//视频直播——开始直播
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class LiveVideoStartPage extends StatefulWidget {
  @override
  _LiveVideoStartPageState createState() => _LiveVideoStartPageState();
}

class _LiveVideoStartPageState extends State<LiveVideoStartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,//键盘弹出背景图片不变形
      body: Stack(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl:
                "https://lanhu.oss-cn-beijing.aliyuncs.com/xdf83a1dd4-aedb-43f6-aad6-a8c1d617225b",
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          LiveTopArea(),
          Positioned(
            left: 11,
            top: MediaQuery.of(context).size.height*110/812,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  color: Color(0xff66333333)),
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
              height: 23,
              child: Row(
                children: <Widget>[
                  Text(
                    "点赞:   " + "6666",
                    style: TextStyle(color: Color(0xff99FFFFFE), fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child: LivwBtArea(),
          )
        ],
      ),
    );
  }
}

//直播底部区域
class LivwBtArea extends StatefulWidget {
  @override
  _LivwBtAreaState createState() => _LivwBtAreaState();
}
class _LivwBtAreaState extends State<LivwBtArea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 267/375*MediaQuery.of(context).size.width,
            height: 200,
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: 4,
              itemBuilder: (context,index){
                return Container(
                  margin: EdgeInsets.only(bottom: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Color(0xff99333333),
                      borderRadius: BorderRadius.circular(4)),
                  child: Text("用户：说点什么什么吧~~~我来啦我来啦啦~我来啦",style:TextStyle(color: Color(0xffCCFFFFFE))),
                );
              },
            ),
          ),
          SizedBox(height:8),
          Container(
            width: MediaQuery.of(context).size.width - 32,
            child: Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xff99333333),
                      borderRadius: BorderRadius.circular(23)),
                  width: 217/375*MediaQuery.of(context).size.width,
                  height: 44/812*MediaQuery.of(context).size.height,
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "说点什么呢~",
                        contentPadding: EdgeInsets.only(left: 12,bottom: 12),
                        hintStyle: TextStyle(color: Color(0xffCCFFFFFE))),
                  ),
                ),
                Spacer(),
                CachedNetworkImage(
                  imageUrl:
                      "https://lanhu.oss-cn-beijing.aliyuncs.com/xdf371cfd2-d64b-4d2d-a4f1-650b545950f4",
                  width: 44/812*MediaQuery.of(context).size.height,
                  height: 44/812*MediaQuery.of(context).size.height,
                ),
                Spacer(),
                CachedNetworkImage(
                  imageUrl:
                      "https://lanhu.oss-cn-beijing.aliyuncs.com/xd199af40b-a038-469b-ac97-dc14a0ad167c",
                  width: 44/812*MediaQuery.of(context).size.height,
                  height: 44/812*MediaQuery.of(context).size.height,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

//直播顶部区域
class LiveTopArea extends StatefulWidget {
  @override
  _LiveTopAreaState createState() => _LiveTopAreaState();
}

class _LiveTopAreaState extends State<LiveTopArea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 9, right: 9, top: MediaQuery.of(context).size.height*44/812),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              color: Color(0xff66333333),
            ),
            padding: EdgeInsets.all(0.5),
            height: MediaQuery.of(context).size.height*50/812,
            width: 198/375*MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl:
                      "https://lanhu.oss-cn-beijing.aliyuncs.com/xdb60a69c6-862d-4072-845e-87d0d9a8892f",
                  width: 40,
                  height: 40,
                ),
                SizedBox(width: 3),
                Column(
                  children: <Widget>[
                    Text(
                      "用户名称",
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                    Spacer(),
                    Text(
                      "22.00万人",
                      style:
                          TextStyle(fontSize: 11, color: Color(0xff99FFFFFE)),
                    )
                  ],
                ),
                Spacer(),
                Container(
                  height: double.infinity,
                  width: 76,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xffFFE1B96B),
                      borderRadius: BorderRadius.circular(23)),
                  child: Text(
                    "关注",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            child: LiveFanList(),
            padding: EdgeInsets.only(top: 3),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CachedNetworkImage(
              imageUrl:
                  "https://lanhu.oss-cn-beijing.aliyuncs.com/xd2bae5e72-d1aa-4ab5-bbd8-1fd222878725",
              width: 40/375*MediaQuery.of(context).size.width,
              height: 40/375*MediaQuery.of(context).size.width,
            ),
          )
        ],
      ),
    );
  }
}

//粉丝前三头像
class LiveFanList extends StatefulWidget {
  @override
  _LiveFanListState createState() => _LiveFanListState();
}

class _LiveFanListState extends State<LiveFanList> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 90/375*MediaQuery.of(context).size.width,
          height: 40/375*MediaQuery.of(context).size.width,
        ),
        Positioned(
          right: 0,
          child: CachedNetworkImage(
            imageUrl:
                "https://lanhu.oss-cn-beijing.aliyuncs.com/xd2af2bee3-4231-407a-b0de-518e0ac26f37",
            width: 40/375*MediaQuery.of(context).size.width,
            height: 40/375*MediaQuery.of(context).size.width,
          ),
        ),
        Positioned(
          right: 26/375*MediaQuery.of(context).size.width,
          child: CachedNetworkImage(
            imageUrl:
                "https://lanhu.oss-cn-beijing.aliyuncs.com/xd2af2bee3-4231-407a-b0de-518e0ac26f37",
            width: 40/375*MediaQuery.of(context).size.width,
            height: 40/375*MediaQuery.of(context).size.width,
          ),
        ),
        Positioned(
          left: 0,
          child: CachedNetworkImage(
            imageUrl:
                "https://lanhu.oss-cn-beijing.aliyuncs.com/xd2af2bee3-4231-407a-b0de-518e0ac26f37",
            width: 40/375*MediaQuery.of(context).size.width,
            height: 40/375*MediaQuery.of(context).size.width,
          ),
        )
      ],
    );
  }
}
