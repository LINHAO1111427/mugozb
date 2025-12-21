//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "ActivitiesSimpleInfoVOModel.h"

#import "RechargeGiftVOModel.h"

#import "AdminLoginAwardVOModel.h"

typedef void (^CallBackOperationController_ActivitiesSimpleInfoVOArr)(int code,NSString *strMsg,NSArray<ActivitiesSimpleInfoVOModel*>* arr);
typedef void (^CallBackOperationController_RechargeGiftVOArr)(int code,NSString *strMsg,NSArray<RechargeGiftVOModel*>* arr);
typedef void (^CallBackOperationController_AdminLoginAwardVO)(int code,NSString *strMsg,AdminLoginAwardVOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
运营控制层
 */
@interface HttpApiOperationController: NSObject



/**
 其他活动后台页面
 */
+(void) getActivitiesList:(CallBackOperationController_ActivitiesSimpleInfoVOArr)callback;


/**
 首页首充礼物列表
 */
+(void) firstRechargeGift:(CallBackOperationController_RechargeGiftVOArr)callback;


/**
 获取连续登录奖励
 */
+(void) getContinueLogin:(CallBackOperationController_AdminLoginAwardVO)callback;

@end

NS_ASSUME_NONNULL_END
