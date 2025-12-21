//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

typedef void (^CallBackTencentCloudImController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
提供腾讯IM相关接口
 */
@interface HttpApiTencentCloudImController: NSObject



/**
 app端发送消息到嗡营，后端监听。改为app端直接发送请求到后端
 @param content content
 @param subType subType
 @param type type
 */
+(void) handleListenSocket:(NSString *)content subType:(NSString *)subType type:(NSString *)type  callback:(CallBackTencentCloudImController_HttpNone)callback;


/**
 获取腾讯云用户签名
 @param userid 用户id
 */
+(void) genUserSig:(NSString *)userid  callback:(CallBackTencentCloudImController_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
