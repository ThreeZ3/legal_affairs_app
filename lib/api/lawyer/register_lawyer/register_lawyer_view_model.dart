import 'package:flutter/material.dart';
import 'package:jh_legal_affairs/api/lawyer/register_lawyer/register_lawyer_model.dart';
import 'package:jh_legal_affairs/page/register/common/register_password.dart';
import 'package:jh_legal_affairs/page/register/lawyer/lawyer_information.dart';
import 'package:jh_legal_affairs/util/tools.dart';

RegisterLawyerViewModel registerLawyer = RegisterLawyerViewModel();

class RegisterLawyerViewModel extends BaseViewModel {
  /// lawyer/practice-information 律所注册-插入律师执业信息(put)

  Future<ResponseModel> practiceInformation(
    BuildContext context,
    String phone, {
    String firmName,
    String id,
    String idCardBackImg,
    String idCardImg,
    String lawyerCard,
    String lawyerCardBackImg,
    String lawyerCardImg,
    List<Fields> legalField,
  }) async {
    if (!strNoEmpty(firmName) || firmName == '') {
      throw ResponseModel.fromParamError('请输入执业机构');
    } else if (!strNoEmpty(id) || id == '') {
      throw ResponseModel.fromParamError('请输入律师id');
    } else if (!strNoEmpty(lawyerCard) || lawyerCard == '') {
      throw ResponseModel.fromParamError('请输入执业证号');
    } else if (!listNoEmpty(legalField) || legalField == []) {
      throw ResponseModel.fromParamError('请选择擅长领域');
    } else if (!strNoEmpty(idCardImg) || idCardImg == '') {
      throw ResponseModel.fromParamError('请上传身份证正面');
    } else if (!strNoEmpty(idCardBackImg) || idCardBackImg == '') {
      throw ResponseModel.fromParamError('请上传身份证反面');
    } else if (!strNoEmpty(lawyerCardImg) || lawyerCardImg == '') {
      throw ResponseModel.fromParamError('请上传执业证书');
    }
    ResponseModel data = await PracticeInformationRequestModel(
      firmName: firmName,
      id: id,
      idCardBackImg: idCardBackImg,
      idCardImg: idCardImg,
      lawyerCard: lawyerCard,
      lawyerCardBackImg: lawyerCardBackImg,
      lawyerCardImg: lawyerCardImg,
      legalField: legalField,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.put,
    )
        .then((rep) {
      routePush(RegisterPassword(phone, null, true, rep['data']['id']));
//      routePush(RegisterCode(phone, true, rep['data']['id']));
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }

  /// lawyer/basic-information 律师注册-完善律师基本信息(post)
  Future<ResponseModel> basicInformation(
    BuildContext context, {
    String birthday,
    String city,
    String district,
    String education,
    String email,
    double lat,
    double lng,
    String name,
    String identityCard,
    String province,
    String phone,
    String workYear,
    String sex,
    String code,
  }) async {
    if (!strNoEmpty(name)) {
      throw ResponseModel.fromParamError('请输入名字');
    } else if (!strNoEmpty(sex)) {
      throw ResponseModel.fromParamError('请选择性别');
    } else if (!strNoEmpty(education)) {
      throw ResponseModel.fromParamError('请选择学历');
    } else if (!strNoEmpty(province) &&
        !strNoEmpty(city) &&
        !strNoEmpty(district)) {
      throw ResponseModel.fromParamError('请选择区域');
    } else if (!strNoEmpty(birthday)) {
      throw ResponseModel.fromParamError('请输入生日');
    } else if (!strNoEmpty(email)) {
      throw ResponseModel.fromParamError('请输入邮箱');
    } else if (!isEmail(email)) {
      throw ResponseModel.fromParamError('请输入正确的邮箱');
    } else if (!strNoEmpty(phone)) {
      throw ResponseModel.fromParamError('请输入手机号');
    } else if (!isMobilePhoneNumber(phone)) {
      throw ResponseModel.fromParamError('请输入正确的手机号');
    } else if (!isIdCard(identityCard)) {
      throw ResponseModel.fromParamError('请输入正确的身份证号');
    }
    ResponseModel data = await BasicInformationRequestModel(
      birthday: birthday,
      city: city,
      district: district,
      education: education,
      email: email,
      lat: lat,
      lng: lng,
      name: name,
      identityCard: identityCard,
      province: province,
      sex: int.parse(sex),
      code: code,
      mobile: phone,
      workYear: workYear,
    )
        .sendApiAction(
      context,
      hud: '请求中',
      reqType: ReqType.post,
    )
        .then((rep) {
//      showToast(context, '操作成功');
      routePush(LawyerInformation(phone, rep['data']['id']));
//      routePush(RegisterCode(phone, true, rep['data']['id']));
      return ResponseModel.fromSuccess(rep);
    }).catchError((e) {
      throw ResponseModel.fromError(e.message, e.code);
    });
    return data;
  }
}
