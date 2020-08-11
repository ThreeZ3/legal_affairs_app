import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jh_legal_affairs/util/tools.dart';
import 'package:jh_legal_affairs/widget/law_firm/custom_dialog.dart';

/// 创建者：宋永灵
/// 开发者：宋永灵
/// 创建日期：2020-05-30
///
/// 我的-注册-律师用户-基本信息-补充资料-学历

class EducationPage extends StatefulWidget {
  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  String groupValue = '大专';

  List<Post> posts = [
    Post(name: '大专', isShow: false, type: 0),
    Post(name: '本科', isShow: false, type: 1),
    Post(name: '硕士', isShow: false, type: 2),
    Post(name: '博士', isShow: false, type: 3),
    Post(name: '自定义', isShow: false, type: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      appBar: new NavigationBar(
        title: '学历',
        mainColor: ThemeColors.color333,
        backgroundColor: Colors.white,
        iconColor: ThemeColors.colorOrange,
        brightness: Brightness.light,
        rightDMActions: <Widget>[
          new SizedBox(
            width: 60,
            child: new FlatButton(
              onPressed: () => pop(groupValue),
              padding: EdgeInsets.all(0),
              child: new Text('确定'),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: _listTileItemBuilder,
        itemCount: posts.length,
      ),
    );
  }

  //列表
  Widget _listTileItemBuilder(BuildContext context, int item) {
    return EducationListTile(
      title: posts[item].name,
      trailing: item == posts.length - 1
          ? Icon(
              Icons.keyboard_arrow_right,
              color: Color(0xff707070),
            )
          : groupValue == posts[item].name
              ? Icon(
                  Icons.check_circle_outline,
                  color: Color(0xffE1B96B),
                  size: 16,
                )
              : Container(),
      onTap: item == posts.length - 1
          ? () {
              _showDialogWidget().then((v) {
                if (!listNoEmpty(v)) return;
                setState(() {
                  posts.insert(
                    posts.length - 1,
                    Post(name: v[0], isShow: false, type: -1),
                  );
                });
              });
            }
          : () {
              setState(() {
                posts[item].isShow = !posts[item].isShow;
                updateGroupValue(posts[item].name);
              });
            },
    );
  }

  void updateGroupValue(String v) {
    setState(() {
      groupValue = v;
    });
  }

  //弹出框调用
  Future _showDialogWidget() {
    TextEditingController textController = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return CustomWhiteDialog(
            height: 167,
            title: '自定义学历类型',
            hintText: '输入1-5字',
            textController: textController,
            okBtnOnpressed: () {
              return Navigator.of(context).pop(textController.text);
            },
          );
        });
  }
}

//自定义ListTile组件
class EducationListTile extends StatefulWidget {
  final String title;
  final Widget trailing;
  final Function onTap;

  EducationListTile({this.title, this.trailing, this.onTap});

  @override
  _EducationListTileState createState() => _EducationListTileState();
}

class _EducationListTileState extends State<EducationListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        onTap: widget.onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.title,
              style: TextStyle(
                color: Color(0xff595959),
                fontSize: 14,
              ),
            ),
            Container(
              child: widget.trailing,
            ),
          ],
        ),
      ),
    );
  }
}

//数据
class Post {
  Post({this.name, this.isShow, this.type});

  String name;
  bool isShow;
  int type;
}
