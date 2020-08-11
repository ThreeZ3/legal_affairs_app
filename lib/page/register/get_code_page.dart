import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/login_view_model.dart';
import 'package:jh_legal_affairs/page/register/common/code_input_textfield_widget.dart';
import 'package:jh_legal_affairs/page/register/lawyer/lawyer_information_personal.dart';
import 'package:jh_legal_affairs/util/tools.dart';

class GetCodeCode extends StatefulWidget {
  @override
  _GetCodeCodeState createState() => _GetCodeCodeState();
}

class _GetCodeCodeState extends State<GetCodeCode> {
  TextEditingController _code = TextEditingController();
  TextEditingController _phone = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _code.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new NavigationBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        iconColor: ThemeColors.colorOrange,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 16.0),
                    Text(
                      '输入手机号及验证码',
                      style: TextStyle(
                        color: Color(0xff24262E),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 24.0),
                    new Row(
                      children: <Widget>[
                        Text(
                          '手机号',
                          style: TextStyle(
                              color: ThemeColors.color999, fontSize: 14.0),
                        ),
                        SizedBox(width: 16.0),
                        new Expanded(
                          child: new Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(17, 21, 43, 0.08),
                                ),
                              ),
                            ),
                            child: new TextField(
                              maxLines: 1,
                              inputFormatters: numFormatter,
                              controller: _phone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '输入手机号',
                              ),
                              onChanged: (v) {
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    new SizedBox(height: 24.0),
                    CodeInputTextFieldWidget(
                      controller: _code,
                      phone: _phone.text,
                      isAuthInit: false,
                    ),
                  ],
                ),
              ),
              RegisterButtonWidget(
                title: '下一步',
                onTap: () => checkCodeMethod(),
              ),
              SizedBox(height: winKeyHeight(context) == 0 ? 42.0 : 10.0),
            ],
          ),
        ),
      ),
    );
  }

  void checkCodeMethod() async {
    if (!strNoEmpty(_phone.text) || !strNoEmpty(_code.text)) {
      showToast(context, '请输入参数信息');
    } else {
      // 验证码传给下个接口进行校验
      routePush(LawyerInformationPersonal(_phone.text, _code.text));
//      loginViewModel
//          .checkCode(context, verifyCode: _code.text, mobile: _phone.text)
//          .then((rep) {
//        if (rep != null) {
//          rep.data['code'] == 200
//              ?
//              : showToast(context, '验证码错误');
//        }
//      }).catchError((e) {
//        showToast(context, e.message);
//      });
    }
  }
}
