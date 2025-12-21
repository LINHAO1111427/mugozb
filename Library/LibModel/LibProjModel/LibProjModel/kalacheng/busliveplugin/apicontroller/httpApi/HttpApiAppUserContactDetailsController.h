//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

#import "AppUserContactDetailsVOModel.h"

typedef void (^CallBackAppUserContactDetailsController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackAppUserContactDetailsController_AppUserContactDetailsVO)(int code,NSString *strMsg,AppUserContactDetailsVOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
用户联系方式（和一对一联系方式无关）
 */
@interface HttpApiAppUserContactDetailsController: NSObject



/**
 向用户发送联系方式（和一对一联系方式无关）
 @param roomId 房间号
 @param sendContactType 送联系方式的类型 1：qq 2：微信 3：手机号
 @param toUserId 接收方id
 */
+(void) sendUserContactDetails:(int64_t)roomId sendContactType:(int)sendContactType toUserId:(int64_t)toUserId  callback:(CallBackAppUserContactDetailsController_HttpNone)callback;


/**
 获取用户的联系方式（和一对一联系方式无关）
 */
+(void) getUserContactDetails:(CallBackAppUserContactDetailsController_AppUserContactDetailsVO)callback;


/**
 修改用户的联系方式（和一对一联系方式无关）
 @param phone 手机号
 @param qq qq
 @param weChat 微信
 */
+(void) setUserContactDetails:(NSString *)phone qq:(NSString *)qq weChat:(NSString *)weChat  callback:(CallBackAppUserContactDetailsController_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
