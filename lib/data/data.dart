import 'dart:convert' show jsonDecode;
import 'dart:io';
import 'package:jh_legal_affairs/api/login_model.dart';
import 'package:jh_legal_affairs/data/actions.dart';
export 'package:jh_legal_affairs/data/actions.dart';
import 'package:jh_legal_affairs/data/store.dart';
import 'package:jh_legal_affairs/util/tools.dart';
export 'package:jh_legal_affairs/data/store.dart';

export 'notice.dart';

/// 创建者：王增阳
/// 开发者：王增阳
/// 版本：1.0
/// 创建日期：2020-02-19
///
typedef Finish();

class JHData {
  static initStore({Finish finish}) {
    Store(JHActions.isLogin()).value = false;

    Store(JHActions.isSensitive()).value = Platform.isAndroid ? true : false;

    getStoreValue(JHActions.token()).then((v) {
      Store(JHActions.token()).value = v;
      String str = strNoEmpty(JHData.token())
          ? JHData.token()
          : ' status :is not login yet';
      print('user.token => $str');
    });
    getStoreValue(JHActions.loginResult()).then((onValue) {
      if (strNoEmpty(onValue)) {
        Map data = jsonDecode(onValue);
        UserInfoModel model = UserInfoModel.fromJson(data['data']);
        Store(JHActions.isLogin()).value = true;
        getStoreValue(JHActions.city()).then((v) {
          if (!strNoEmpty(v)) {
            Store(JHActions.city()).value = model.city;
          } else {
            Store(JHActions.city()).value = v;
          }
        });
        getStoreValue(JHActions.district()).then((v) {
          if (!strNoEmpty(v)) {
            Store(JHActions.district()).value = model.district;
          } else {
            Store(JHActions.district()).value = v;
          }
        });
        getStoreValue(JHActions.province()).then((v) {
          if (!strNoEmpty(v)) {
            Store(JHActions.province()).value = model.province;
          } else {
            Store(JHActions.province()).value = v;
          }
        });
        getStoreValue(JHActions.userType()).then((v) {
          if (!strNoEmpty(v)) {
            Store(JHActions.userType()).value = model.type;
          } else {
            Store(JHActions.userType()).value = v;
          }
        });
        getStoreValue(JHActions.firmAdminType()).then((v) {
          if (!strNoEmpty(v)) {
            Store(JHActions.firmAdminType()).value = model.firmAdminType;
          } else {
            Store(JHActions.firmAdminType()).value = v;
          }
        });
        /*Store(JHActions.firmAdminType()).value = model.firmAdminType;*/
        Store(JHActions.id()).value = model.id;
        /*Store(JHActions.firmId()).value = model.firmId;*/
        Store(JHActions.isFirmUser()).value = model.isFirmUser;
        Store(JHActions.inviteCode()).value = model.inviteCode;
        Store(JHActions.loginPassword()).value = model.loginPassword;
        Store(JHActions.status()).value = model.status;
        Store(JHActions.mobile()).value = model.mobile;
        storeString(JHActions.mobile(), model.mobile);
        getStoreValue(JHActions.nickName()).then((v) {
          if (!strNoEmpty(v)) {
            Store(JHActions.nickName()).value = model.nickName;
          } else {
            Store(JHActions.nickName()).value = v;
          }
        });
        getStoreValue(JHActions.avatar()).then((v) {
          if (!strNoEmpty(v)) {
            Store(JHActions.avatar()).value = model.avatar;
          } else {
            Store(JHActions.avatar()).value = v;
          }
        });
        getStoreValue(JHActions.sex()).then((v) {
          if (!strNoEmpty(v)) {
            Store(JHActions.sex()).value = model.sex;
          } else {
            Store(JHActions.sex()).value = v;
          }
        });
        if (finish != null) {
          finish();
        }
      }
    });
  }

  static clean() {
    storeClean();
    Store(JHActions.isLogin()).value = false;
    Store(JHActions.token()).value = null;
    Store(JHActions.city()).value = null;
    Store(JHActions.nickName()).value = null;
    Store(JHActions.sex()).value = null;
    Store(JHActions.district()).value = null;
    Store(JHActions.avatar()).value = null;
    Store(JHActions.province()).value = null;
    Store(JHActions.mobile()).value = null;
    Store(JHActions.refreshToken()).value = null;
    Store(JHActions.loginResult()).value = null;
    Store(JHActions.userType()).value = null;
    Store(JHActions.status()).value = null;
    Store(JHActions.isFirmUser()).value = null;
    Store(JHActions.firmAdminType()).value = null;
    Notice.send(JHActions.toTabBarIndex(), 0);
  }

  static String id() => Store(JHActions.id()).value ?? '';

  /*static String firmId() => Store(JHActions.firmId()).value ?? '';*/

  static String token() => Store(JHActions.token()).value ?? '';

  static String avatar() =>
      Store(JHActions.avatar()).value ?? userDefaultAvatarOld;

  static bool isLogin() => Store(JHActions.isLogin()).value ?? false;

  static bool isMockLogin() => Store(JHActions.isMockLogin()).value ?? false;

  static String inviteCode() => Store(JHActions.inviteCode()).value ?? '111111';

  static String nickName() => Store(JHActions.nickName()).value ?? '';

  static String userType() => Store(JHActions.userType()).value ?? '';

  static int firmAdminType() => Store(JHActions.firmAdminType()).value ?? null;

  static String mobile() => Store(JHActions.mobile()).value ?? '';

  static String appVersion() => Store(JHActions.appVersion()).value ?? '';

  static String lawyerInfo() => Store(JHActions.lawyerInfo()).value ?? '';

  static String lawyerValue() => Store(JHActions.lawyerValue()).value ?? '';

  static String sex() => Store(JHActions.sex()).value ?? '0';

  static int status() => Store(JHActions.status()).value ?? 0;

  static String district() => Store(JHActions.district()).value ?? '未知区';

  static String city() => Store(JHActions.city()).value ?? '未知市';

  static String province() => Store(JHActions.province()).value ?? '未知省';

  static bool isFirmUser() => Store(JHActions.isFirmUser()).value ?? false;

  static bool isSensitive() =>
      Platform.isAndroid ? true : Store(JHActions.isSensitive()).value ?? false;
}
