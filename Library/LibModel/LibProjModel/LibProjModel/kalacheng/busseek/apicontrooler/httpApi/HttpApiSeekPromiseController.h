//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "AppShowUserPromiseOrderEvaluateVOModel.h"

#import "HttpNoneModel.h"

#import "AppShowOrderNumberVOModel.h"

#import "AppShowPromiseOrderVOModel.h"

#import "AppPromiseOrderInfoVOModel.h"

typedef void (^CallBackSeekPromiseController_AppShowUserPromiseOrderEvaluateVO)(int code,NSString *strMsg,AppShowUserPromiseOrderEvaluateVOModel* model);
typedef void (^CallBackSeekPromiseController_HttpNone)(int code,NSString *strMsg,HttpNoneModel* model);
typedef void (^CallBackSeekPromiseController_AppShowOrderNumberVO)(int code,NSString *strMsg,AppShowOrderNumberVOModel* model);
typedef void (^CallBackSeekPromiseController_AppShowPromiseOrderVOArr)(int code,NSString *strMsg,NSArray<AppShowPromiseOrderVOModel*>* arr);
typedef void (^CallBackSeekPromiseController_AppPromiseOrderInfoVO)(int code,NSString *strMsg,AppPromiseOrderInfoVOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
寻觅邀约相关控制层
 */
@interface HttpApiSeekPromiseController: NSObject



/**
 获取用户评分，评论，订单标签
 @param toUserId 被查询的用户id
 */
+(void) getAppShowUserPromiseOrderEvaluateVO:(int64_t)toUserId  callback:(CallBackSeekPromiseController_AppShowUserPromiseOrderEvaluateVO)callback;


/**
 用户确认订单完成
 @param promiseOrderId 订单id
 */
+(void) seekUserConfirm:(int64_t)promiseOrderId  callback:(CallBackSeekPromiseController_HttpNone)callback;


/**
 约定结束，主播确认安全离开
 @param promiseOrderId 订单id
 */
+(void) seekAnchorLeave:(int64_t)promiseOrderId  callback:(CallBackSeekPromiseController_HttpNone)callback;


/**
 获取用户进行中和待评价订单 数量
 */
+(void) getAppShowOrderNumber:(CallBackSeekPromiseController_AppShowOrderNumberVO)callback;


/**
 添加寻觅订单
 @param address 预约详细地址
 @param anchorId 主播id
 @param city 预约 市
 @param latitude 纬度
 @param longitude 经度
 @param promiseDuration 预约时长
 @param promiseStartTime 预约时间
 @param skillTypeId 技能类型id
 @param store 预约门店名称
 */
+(void) addPromiseOrder:(NSString *)address anchorId:(int64_t)anchorId city:(NSString *)city latitude:(double)latitude longitude:(double)longitude promiseDuration:(int)promiseDuration promiseStartTime:(NSString *)promiseStartTime skillTypeId:(int64_t)skillTypeId store:(NSString *)store  callback:(CallBackSeekPromiseController_HttpNone)callback;


/**
 用户取消订单
 @param promiseOrderId 订单id
 @param refuseDescription 取消的描述
 @param refuseReason 取消的原因
 @param refuseTypeId 取消的类型id
 */
+(void) userCancelOrder:(int64_t)promiseOrderId refuseDescription:(NSString *)refuseDescription refuseReason:(NSString *)refuseReason refuseTypeId:(int64_t)refuseTypeId  callback:(CallBackSeekPromiseController_HttpNone)callback;


/**
 获取用户的订单列表
 @param pageIndex 当前页
 @param pageSize 每页页数
 @param queryType 查询类型 0：全部 1：进行中 2：待评价 3：已完结
 */
+(void) getAppShowPromiseOrderVO:(int)pageIndex pageSize:(int)pageSize queryType:(int)queryType  callback:(CallBackSeekPromiseController_AppShowPromiseOrderVOArr)callback;


/**
 获取用户一个订单详情
 @param latitude 纬度
 @param longitude 经度
 @param promiseOrderId 订单id
 */
+(void) getAppPromiseOrderInfoVO:(double)latitude longitude:(double)longitude promiseOrderId:(int64_t)promiseOrderId  callback:(CallBackSeekPromiseController_AppPromiseOrderInfoVO)callback;


/**
 主播回复
 @param anchorReply 主播回复状态 1：同意 -1：拒绝
 @param promiseOrderId 订单id
 @param refuseDescription 拒绝的描述 （同意传 空字符串）
 @param refuseReason 拒绝的原因（拒绝类型的名称）（同意传 空字符串）
 @param refuseTypeId 拒绝的类型id（同意传 0）
 */
+(void) anchorReply:(int)anchorReply promiseOrderId:(int64_t)promiseOrderId refuseDescription:(NSString *)refuseDescription refuseReason:(NSString *)refuseReason refuseTypeId:(int64_t)refuseTypeId  callback:(CallBackSeekPromiseController_HttpNone)callback;


/**
 用户订单评价（评分+评论+标签）
 @param orderComment 订单评论
 @param orderScore 订单评分
 @param promiseOrderId 订单id
 @param promiseOrderTagIds 寻觅订单标签id（多个用逗号隔开）
 @param toUserId 被评价的用户id
 */
+(void) addPromiseOrderEvaluate:(NSString *)orderComment orderScore:(double)orderScore promiseOrderId:(int64_t)promiseOrderId promiseOrderTagIds:(NSString *)promiseOrderTagIds toUserId:(int64_t)toUserId  callback:(CallBackSeekPromiseController_HttpNone)callback;


/**
 添加用户申诉
 @param promiseOrderId 申诉的订单id
 @param seekAppealDescription 申诉描述
 @param seekAppealImages 申诉图片(多张逗号隔开)
 @param seekAppealTypeId 申述类型id
 @param seekAppealTypeName 申述类型名称
 */
+(void) addUserAppeal:(int64_t)promiseOrderId seekAppealDescription:(NSString *)seekAppealDescription seekAppealImages:(NSString *)seekAppealImages seekAppealTypeId:(int64_t)seekAppealTypeId seekAppealTypeName:(NSString *)seekAppealTypeName  callback:(CallBackSeekPromiseController_HttpNone)callback;


/**
 寻觅续单
 @param promiseOrderId 订单id
 @param renewalTime 续单时长（小时）
 */
+(void) orderRenewal:(int64_t)promiseOrderId renewalTime:(int)renewalTime  callback:(CallBackSeekPromiseController_HttpNone)callback;

@end

NS_ASSUME_NONNULL_END
