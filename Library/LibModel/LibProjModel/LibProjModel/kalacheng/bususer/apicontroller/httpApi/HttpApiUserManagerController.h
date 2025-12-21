//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "MsgNotifySwitchVOModel.h"

#import "HttpNoneModel.h"

#import "UserAppealTypeVOModel.h"

typedef void (^CallBackUserManagerController_MsgNotifySwitchVO)(int code,NSString *strMsg,MsgNotifySwitchVOModel* model);
typedef void (^CallBackUserManagerController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackUserManagerController_UserAppealTypeVOArr)(int code,NSString *strMsg,NSArray<UserAppealTypeVOModel*>* arr);
NS_ASSUME_NONNULL_BEGIN



/**
用户管理，以后这里当作主入口()
 */
@interface HttpApiUserManagerController: NSObject



/**
 查询用户app的消息设置开关
 */
+(void) getMsgNotifySwitch:(CallBackUserManagerController_MsgNotifySwitchVO)callback;


/**
 添加用户举报信息
 @param toUserId 被举报人id
 @param userAppealDescription 用户举报描述
 @param userAppealImages 用户举报图片
 @param userAppealTypeId 用户举报分类id
 @param userAppealTypeName 用户举报分类名称
 */
+(void) addUserAppeal:(int64_t)toUserId userAppealDescription:(NSString *)userAppealDescription userAppealImages:(NSString *)userAppealImages userAppealTypeId:(int64_t)userAppealTypeId userAppealTypeName:(NSString *)userAppealTypeName  callback:(CallBackUserManagerController_HttpNone)callback;


/**
 更新用定位信息(经纬度和地址)
 @param address 详细地址
 @param city 城市
 @param lat 纬度(没值传-1)
 @param lng 经度(没值传-1)
 */
+(void) upLocationInformation:(NSString *)address city:(NSString *)city lat:(double)lat lng:(double)lng  callback:(CallBackUserManagerController_HttpNone)callback;


/**
 获取用户举报类型
 */
+(void) getUserAppealTypeList:(CallBackUserManagerController_UserAppealTypeVOArr)callback;


/**
 修改用户app的消息设置开关
 @param toneSwitch 提示音开关 0：关闭 1：开启
 */
+(void) upMsgNotifySwitch:(int)toneSwitch  callback:(CallBackUserManagerController_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
