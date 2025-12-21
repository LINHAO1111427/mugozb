//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

#import "AppSvipVOModel.h"

typedef void (^CallBackAppSvip_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackAppSvip_AppSvipVO)(int code,NSString *strMsg,AppSvipVOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
svip控制器
 */
@interface HttpApiAppSvip: NSObject



/**
 查询用户隐藏距离的状态(特权关闭时,一直返回0)
 */
+(void) getUserHideDistance:(CallBackAppSvip_HttpNone)callback;


/**
 用户点击开通SVIP服务 1开通成功！ 2余额不足请充值！ 3扣费不成功开通SVIP失败！ 4已经是svip会员了
 @param id 要开通的svip服务的套餐id
 */
+(void) openMember:(int64_t)id_field  callback:(CallBackAppSvip_HttpNone)callback;


/**
 null
 */
+(void) getAppSvip:(CallBackAppSvip_AppSvipVO)callback;


/**
 修改用户隐藏距离的状态
 @param hideDistance 隐藏距离 0:不隐藏 1:隐藏
 */
+(void) setUserHideDistance:(int)hideDistance  callback:(CallBackAppSvip_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
