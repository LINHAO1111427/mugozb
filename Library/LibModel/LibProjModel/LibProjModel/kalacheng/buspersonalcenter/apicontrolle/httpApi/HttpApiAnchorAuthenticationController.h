//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

#import "AnchorAuthVOModel.h"
typedef void (^CallBackAnchorAuthenticationController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackAnchorAuthenticationController_AnchorAuthVO)(int code,NSString *strMsg,AnchorAuthVOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
主播认证控制器
 */
@interface HttpApiAnchorAuthenticationController: NSObject



/**
 申请认证
 @param vo vo
 */
+(void) applyAuth:(AnchorAuthVOModel* )vo  callback:(CallBackAnchorAuthenticationController_HttpNone)callback;


/**
 获取主播认证信息
 */
+(void) authInfo:(CallBackAnchorAuthenticationController_AnchorAuthVO)callback;


/**
 认证信息修改
 @param vo vo
 */
+(void) authUpdate:(AnchorAuthVOModel* )vo  callback:(CallBackAnchorAuthenticationController_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
