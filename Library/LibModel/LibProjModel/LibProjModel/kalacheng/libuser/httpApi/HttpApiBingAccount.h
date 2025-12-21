//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "UserTokenModel.h"

#import "HttpNoneModel.h"

#import "UserLogoutVerificationDTOModel.h"

typedef void (^CallBackBingAccount_UserToken)(int code,NSString *strMsg,UserTokenModel* model);
typedef void (^CallBackBingAccount_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackBingAccount_UserLogoutVerificationDTO)(int code,NSString *strMsg,UserLogoutVerificationDTOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
用户账号
 */
@interface HttpApiBingAccount: NSObject



/**
 更换绑定手机号
 @param code 验证码
 @param mobile 手机号码
 @param smsRegion 手机号区域
 @param source 注册来源android/ios
 */
+(void) updateBindMobile:(NSString *)code mobile:(NSString *)mobile smsRegion:(NSString *)smsRegion source:(NSString *)source  callback:(CallBackBingAccount_UserToken)callback;


/**
 验证当前登录密码
 @param password 登录密码
 */
+(void) verifyLoginPwd:(NSString *)password  callback:(CallBackBingAccount_HttpNone)callback;


/**
 用户注销验证
 */
+(void) logoutVerification:(CallBackBingAccount_UserLogoutVerificationDTO)callback;

@end

NS_ASSUME_NONNULL_END
