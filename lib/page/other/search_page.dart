import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/lawyer/lawyer_view_model.dart';
import 'package:jh_legal_affairs/model/firm_list_view_model.dart';
import 'package:jh_legal_affairs/page/law_firm/law_firm_page.dart';
import 'package:jh_legal_affairs/page/lawyer/lawyer_page.dart';
import 'package:jh_legal_affairs/util/tools.dart';

enum SearchType { firm, lawyer }

class SearchPage extends StatefulWidget {
  final SearchType type;
  final Callback callback;

  SearchPage(this.type, {this.callback});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List data = new List();
  bool isLoadingOk = true;
  TextEditingController textEditingController = new TextEditingController();
  int _goPage = 1;

  @override
  Widget build(BuildContext context) {
    return new MainInputBody(
      child: new Scaffold(
        appBar: new NavigationBar(
          titleW: new Container(
            height: navigationBarHeight(context) / 1.5,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: new TextField(
              autofocus: true,
              controller: textEditingController,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
              ),
            ),
          ),
          rightDMActions: <Widget>[
            new SmallButton(
              padding: EdgeInsets.symmetric(horizontal: 2),
              margin: EdgeInsets.symmetric(vertical: 5),
              child: new Text('搜索'),
              onPressed: () => onSearch(),
            ),
            new Space(width: mainSpace / 2),
          ],
        ),
        body: new DataView(
          isLoadingOk: isLoadingOk,
          data: data,
          onRefresh: !strNoEmpty(textEditingController.text)
              ? null
              : () {
                  if (widget.type == SearchType.firm) {
                    return getFirm(true);
                  } else {
                    return getLawyer(true);
                  }
                },
          onLoad: !strNoEmpty(textEditingController.text)
              ? null
              : () {
                  _goPage++;
                  if (widget.type == SearchType.firm) {
                    return getFirm();
                  } else {
                    return getLawyer();
                  }
                },
          child: new ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var model = data[index];
              if (widget.type == SearchType.firm) {
                return LawFirmItem(model);
              } else {
                return LawyerItem(model, callback: widget.callback);
              }
            },
          ),
        ),
      ),
    );
  }

  onSearch() {
    if (!strNoEmpty(textEditingController.text)) {
      showToast(context, '请输入搜索内容');
      return;
    } else if (widget.type == SearchType.firm) {
      FocusScope.of(context).requestFocus(new FocusNode());
      setState(() => isLoadingOk = false);
      getFirm(true);
    } else {
      FocusScope.of(context).requestFocus(new FocusNode());
      setState(() => isLoadingOk = false);
      getLawyer(true);
    }
  }

  Future getFirm([bool isInit = false]) async {
    if (isInit) _goPage = 1;
    return firmListViewModel
        .firmList(
      context,
      limit: 15,
      page: _goPage,
      name: textEditingController.text,
    )
        .then((ResponseModel rep) {
      setState(() {
        if (_goPage == 1) {
          data = List.from(rep.data);
        } else {
          data.addAll(List.from(rep.data));
        }
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
  }

  Future getLawyer([bool isInit = false]) async {
    if (isInit) _goPage = 1;

    return lawyerViewModel
        .lawyerSearch(
      context,
      limit: 15,
      page: _goPage,
      name: textEditingController.text,
    )
        .then((rep) {
      setState(() {
        if (_goPage == 1) {
          data = List.from(rep.data);
        } else {
          data.addAll(List.from(rep.data));
        }
        isLoadingOk = true;
      });
    }).catchError((e) {
      setState(() => isLoadingOk = true);
      showToast(context, e.message);
    });
  }
}
