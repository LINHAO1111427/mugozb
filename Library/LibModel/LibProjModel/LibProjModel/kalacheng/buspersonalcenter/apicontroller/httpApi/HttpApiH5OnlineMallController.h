//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

#import "AppOpenNobleDTOModel.h"

#import "MountDetailDTOModel.h"

#import "MyPackageDTOModel.h"

#import "OnlineMallDTOModel.h"

#import "AppNobleCenterDTOModel.h"

#import "SimpleUserDTOModel.h"

typedef void (^CallBackH5OnlineMallController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackH5OnlineMallController_AppOpenNobleDTO)(int code,NSString *strMsg,AppOpenNobleDTOModel* model);
typedef void (^CallBackH5OnlineMallController_MountDetailDTO)(int code,NSString *strMsg,MountDetailDTOModel* model);
typedef void (^CallBackH5OnlineMallController_MyPackageDTO)(int code,NSString *strMsg,MyPackageDTOModel* model);
typedef void (^CallBackH5OnlineMallController_OnlineMallDTO)(int code,NSString *strMsg,OnlineMallDTOModel* model);
typedef void (^CallBackH5OnlineMallController_AppNobleCenterDTO)(int code,NSString *strMsg,AppNobleCenterDTOModel* model);
typedef void (^CallBackH5OnlineMallController_SimpleUserDTO)(int code,NSString *strMsg,SimpleUserDTOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
新版在线商城
 */
@interface HttpApiH5OnlineMallController: NSObject



/**
 修改用户麦位饰品状态
 @param seatid seatid
 @param state state
 */
+(void) changeMicSeat:(int64_t)seatid state:(int)state  callback:(CallBackH5OnlineMallController_HttpNone)callback;


/**
 贵族中心-开通贵族
 @param grade 贵族等级
 */
+(void) openNoble:(int)grade  callback:(CallBackH5OnlineMallController_AppOpenNobleDTO)callback;


/**
 查看靓号详情
 @param ismy ismy
 @param liangId liangId
 */
+(void) getLiangDetail:(int)ismy liangId:(int64_t)liangId  callback:(CallBackH5OnlineMallController_MountDetailDTO)callback;


/**
 购买麦位装饰
 @param seatid seatid
 @param touid touid
 */
+(void) toBuyMicSeat:(int)seatid touid:(int)touid  callback:(CallBackH5OnlineMallController_HttpNone)callback;


/**
 购买用户靓号
 @param liangid liangid
 @param touid touid
 */
+(void) toBuyLiang:(int64_t)liangid touid:(int64_t)touid  callback:(CallBackH5OnlineMallController_HttpNone)callback;


/**
 我的背包
 */
+(void) myPackage:(CallBackH5OnlineMallController_MyPackageDTO)callback;


/**
 查询坐骑详情
 @param carId carId
 @param ismy ismy
 */
+(void) getCarDetail:(int64_t)carId ismy:(int)ismy  callback:(CallBackH5OnlineMallController_MountDetailDTO)callback;


/**
 购买用户坐骑
 @param carid carid
 @param touid touid
 */
+(void) toBuyCar:(int)carid touid:(int)touid  callback:(CallBackH5OnlineMallController_HttpNone)callback;


/**
 修改用户坐骑状态
 @param carid carid
 @param state state
 */
+(void) changeCar:(int64_t)carid state:(int)state  callback:(CallBackH5OnlineMallController_HttpNone)callback;


/**
 装扮中心信息
 */
+(void) appUserVip:(CallBackH5OnlineMallController_OnlineMallDTO)callback;


/**
 贵族中心
 @param grade 贵族等级
 */
+(void) nobleCenter:(int)grade  callback:(CallBackH5OnlineMallController_AppNobleCenterDTO)callback;


/**
 通过uid搜索用户
 @param uid uid
 */
+(void) searchUser:(int64_t)uid  callback:(CallBackH5OnlineMallController_SimpleUserDTO)callback;


/**
 金币购买贵族
 @param grade 贵族等级
 @param nobleId 贵族价格ID
 */
+(void) buyNoble:(int)grade nobleId:(int64_t)nobleId  callback:(CallBackH5OnlineMallController_HttpNone)callback;


/**
 修改用户靓号状态
 @param liangid liangid
 @param state state
 */
+(void) changeLiang:(int64_t)liangid state:(int)state  callback:(CallBackH5OnlineMallController_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
