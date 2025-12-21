//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "HttpNoneModel.h"

#import "PrivilegeShowInfoModel.h"

typedef void (^CallBackNobleController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackNobleController_PrivilegeShowInfo)(int code,NSString *strMsg,PrivilegeShowInfoModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
贵族控制器
 */
@interface HttpApiNobleController: NSObject



/**
 贵族特权修改
 @param broadCast 全站广播功能 0:关闭 1:开启
 @param chargeShow 充值隐身 0:不隐身 1:隐身
 @param devoteShow 贡献榜排行隐身 0:不隐身 1:隐身
 @param joinRoomShow 进入直播间隐身 0:不隐身 1:隐身
 */
+(void) upPrivilegeShowInfo:(int)broadCast chargeShow:(int)chargeShow devoteShow:(int)devoteShow joinRoomShow:(int)joinRoomShow  callback:(CallBackNobleController_HttpNone)callback;


/**
 查询贵族特权设置
 */
+(void) getPrivilegeShowInfo:(CallBackNobleController_PrivilegeShowInfo)callback;


/**
 查询特权
 @param privilegeNo 特权序号
 */
+(void) getIsOwnerPrivilege:(int)privilegeNo  callback:(CallBackNobleController_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
