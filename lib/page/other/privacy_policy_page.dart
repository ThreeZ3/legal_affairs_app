import 'package:flutter/material.dart';

import 'package:jh_legal_affairs/util/tools.dart';

class PrivacyPolicyPage extends StatefulWidget {
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new NavigationBar(title: '法π归属与隐私政策'),
      body: new ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          new Text(content),
        ],
      ),
    );
  }
}


String content = '''在使用本平台各项服务前，请您仔细阅读并理解本声明。如您选择使用本平台服务，将视为您对本声明内容的同意。除另有说明，本声明中相关用语的含义与《注册协议》中的定义一致。
除本平台自行开发的内容或产品外，其他信息均由甲方提供，该等信息的真实、准确、合法、有效由相对应的甲方承担责任。本平台展示的信息并不意味着本平台赞同其观点或证实其内容的真实与准确。任何单位或个人认为本平台内容涉嫌侵犯其合法权益的，应及时通过书面方式向本平台提出，并提交相关证明文件，包括但不限于身份证明、权利证明、侵权事实等。本平台在收到前述文件后，将对相关侵权内容依法及时予以处理。
一、权利归属
1、除非本平台另有声明，本平台内的所有产品、技术、软件、程序、数据及其他信息（包括但不限于文字、图标、图片、照片、音频、视频、图表、色彩组合、版面设计等）的所有权利（包括但不限于版权、商标权、专利权、商业秘密等）均由本平台经营者或其关联公司所有。
2、未经本平台经营者或其关联公司书面许可，任何人不得以任何程序或设备监视、复制、传播、展示、镜像及其他方式使用本平台内的任何内容。
二、隐私政策
本平台高度重视并保护所有使用本平台的人员之隐私权。为了提供更准确和个性化服务，本平台会按照本政策的规定使用甲方的个人信息，本平台将以高度勤勉、审慎义务对待该等信息。除本政策另有规定外，在未征得甲方事先许可的情况下，本平台不会将这些信息对外披露或向第三方提供。本平台将不时更新隐私权政策。本隐私权政策作为本平台注册协议的组成部分，您在同意注册协议时，即视为您已经同意本隐私政策的全部内容。
1、适用范围
（1）在您注册或登录本平台账户时，您提供的注册信息，包括但不限于姓名、身份证号、公司名称、统一社会信用代码、手机号、邮箱号、地址、注册时间、登录时间、预约详情、咨询详情、订单详情及您注册时上传的证件资料等数据；
（2）在您使用本平台服务或访问本平台时，您的浏览器和计算机上的信息，包括但不限于IP地址、浏览器的类型、使用的语言、访问日期和时间、软硬件特征信息及您需求的网页记录等数据；
（3）如您使用本平台移动客户端软件，或访问本平台移动网页时，与您位置及移动设备相关的信息，包括但不限于设备型号、设备识别码、操作系统、分辨率、电信运营商等；
（4）以下信息不适用本隐私权政策：您在使用本平台提供的搜索服务时输入的信息、您发布需求时选择的法律类别、服务方式、服务时限、选定律师的信息、评价信息等与交易相关的信息；违反法律法规或违反本平台规则的信息。
2、信息的使用和保护
（1）本平台仅在以下情况使用或披露您的信息：
a事先获得您的同意；
b只有披露该等信息，才能提供您所要求的产品或服务；
c根据法律相关规定或者行政、司法机构的要求向第三方或者行政、司法机构披露；
d为使本平台会员或其他方的人身财产权利免受重大损害；
e为维护本平台的交易秩序及合法权益；
f您违反了法律法规或本平台服务条款、规则、协议、政策等规定；
g其他依据法律法规或本平台服务政策认为适当的披露。
（2）本平台可能会与第三方合作向会员提供相关的服务，如该第三方同意承担与本平台同等的保护用户隐私的责任，则本平台有权将会员的相关信息等提供给该第三方。
（3）在不透露单个会员隐私资料的前提下，本平台有权对整个会员数据库进行分析并进行商业上的利用。
3、信息安全
在使用本平台服务时，您可能涉及要向交易对方或潜在的交易对方披露自己的相关信息。请您妥善保护自己的信息，仅在必要的情形下向他人提供。如您发现自己的信息泄露，尤其是您的账户及密码发生泄露，请您立即联络本平台，以便本平台采取相应措施。''';