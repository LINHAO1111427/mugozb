//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "AppPromiseOrderAppealTypeVOModel.h"

#import "CfgWordDictionaryVOModel.h"

#import "AppPromiseOrderTagVOModel.h"

#import "AppPromiseOrderRefuseTypeVOModel.h"

#import "AppOtherUserSkillTextVOModel.h"

#import "AppSeekBannerVOModel.h"

typedef void (^CallBackSeekConfigController_AppPromiseOrderAppealTypeVOArr)(int code,NSString *strMsg,NSArray<AppPromiseOrderAppealTypeVOModel*>* arr);
typedef void (^CallBackSeekConfigController_CfgWordDictionaryVOArr)(int code,NSString *strMsg,NSArray<CfgWordDictionaryVOModel*>* arr);
typedef void (^CallBackSeekConfigController_AppPromiseOrderTagVOArr)(int code,NSString *strMsg,NSArray<AppPromiseOrderTagVOModel*>* arr);
typedef void (^CallBackSeekConfigController_AppPromiseOrderRefuseTypeVOArr)(int code,NSString *strMsg,NSArray<AppPromiseOrderRefuseTypeVOModel*>* arr);
typedef void (^CallBackSeekConfigController_AppOtherUserSkillTextVO)(int code,NSString *strMsg,AppOtherUserSkillTextVOModel* model);
typedef void (^CallBackSeekConfigController_AppSeekBannerVOArr)(int code,NSString *strMsg,NSArray<AppSeekBannerVOModel*>* arr);
NS_ASSUME_NONNULL_BEGIN



/**
寻觅约定相关控制层
 */
@interface HttpApiSeekConfigController: NSObject



/**
 获取用户订单申诉类型（用户申诉类型）
 */
+(void) getPromiseOrderAppealTypeList:(CallBackSeekConfigController_AppPromiseOrderAppealTypeVOArr)callback;


/**
 获取文字描述list 1:技能文字描述 2:档期描述 3:（邀约）温馨提示 4：预约信息
 */
+(void) getCfgWordDictionaryVO:(CallBackSeekConfigController_CfgWordDictionaryVOArr)callback;


/**
 获取订单标签（评价的时候用）
 */
+(void) getPromiseOrderTagList:(CallBackSeekConfigController_AppPromiseOrderTagVOArr)callback;


/**
 获取订单拒绝/取消类型（拒绝原因）
 @param optType 操作类型 1：拒绝 2：取消
 */
+(void) getAppPromiseOrderRefuseTypeList:(int)optType  callback:(CallBackSeekConfigController_AppPromiseOrderRefuseTypeVOArr)callback;


/**
 看看别人怎么写
 @param skillTypeId 技能类型id
 */
+(void) getOtherUserSkillText:(int64_t)skillTypeId  callback:(CallBackSeekConfigController_AppOtherUserSkillTextVO)callback;


/**
 获取banner图集合
 @param bannerType 轮播类型 1：首页轮播图
 */
+(void) getSeekBannerList:(int)bannerType  callback:(CallBackSeekConfigController_AppSeekBannerVOArr)callback;

@end

NS_ASSUME_NONNULL_END
