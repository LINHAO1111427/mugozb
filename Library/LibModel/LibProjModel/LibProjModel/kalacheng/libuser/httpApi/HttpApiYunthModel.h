//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

typedef void (^CallBackYunthModel_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
青少年模式
 */
@interface HttpApiYunthModel: NSObject



/**
 开启/关闭青少年模式
 @param isYouthModel 1开启，2关闭
 @param pwd 密码
 */
+(void) setYunthModel:(int)isYouthModel pwd:(NSString *)pwd  callback:(CallBackYunthModel_HttpNone)callback;


/**
 账号密码验证
 @param password 当前账号密码
 */
+(void) yunthAuthByAccount:(NSString *)password  callback:(CallBackYunthModel_HttpNone)callback;


/**
 通过验证码验证
 @param code 验证码
 @param mobile 手机号
 */
+(void) yunthAuthByCode:(NSString *)code mobile:(NSString *)mobile  callback:(CallBackYunthModel_HttpNone)callback;


/**
 修改青少年密码
 @param password 青少年密码
 */
+(void) updateYunthPwd:(NSString *)password  callback:(CallBackYunthModel_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
