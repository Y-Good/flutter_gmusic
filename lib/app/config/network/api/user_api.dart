///
/// @Author: YGood
/// @Description: 你在做咩呀
/// @CreateDate: 2022-08-22 14:04
/// @UpdateDate: 2022-08-22 14:04

class UserApi {
  UserApi._();

  ///登录
  static const String login = "/login/cellphone";

  /// 获取验证码
  static const String captchaSent = "/captcha/sent";

  /// 验证验证码
  static const String captchaVerify = "/captcha/verify";
}
