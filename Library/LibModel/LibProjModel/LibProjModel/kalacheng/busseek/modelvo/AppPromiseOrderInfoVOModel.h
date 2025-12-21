//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
我的档期其中一个订单
 */
@interface AppPromiseOrderInfoVOModel : NSObject 


	/**
(预计)邀约开始时间
 */
@property (nonatomic,copy) NSDate * promiseStartTime;

	/**
距离(千米)
 */
@property (nonatomic, assign) double distance;

	/**
用户是否发起申诉 0：没有 1：申述中 2：申述处理完成
 */
@property (nonatomic, assign) int isUserAppeal;

	/**
订单总价格
 */
@property (nonatomic, assign) double totalPrice;

	/**
约定的纬度
 */
@property (nonatomic, assign) double latitude;

	/**
显示的用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
订单状态 1：待回复 2：待见面（未到约定时间）3：已见面（已到约定时间） 4：约会结束（系统约定时间已到） 5:双方确认(或约会完成后超3小时) 6:结算中（等待24小时） 7：订单完结 8：订单已取消 9：主播拒绝
 */
@property (nonatomic, assign) int orderStatus;

	/**
主播ID
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
用户在本订单中的角色 1：用户 2：主播
 */
@property (nonatomic, assign) int orderRole;

	/**
显示的用户名
 */
@property (nonatomic, copy) NSString * userName;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
主播是否安全离开 0：没有 1：安全离开
 */
@property (nonatomic, assign) int isAnchorLeave;

	/**
约定的市
 */
@property (nonatomic, copy) NSString * promiseCity;

	/**
订单id
 */
@property (nonatomic, assign) int64_t promiseOrderId;

	/**
邀约时长（最多6小时）
 */
@property (nonatomic, assign) int promiseDuration;

	/**
技能名称
 */
@property (nonatomic, copy) NSString * skillName;

	/**
约定门店
 */
@property (nonatomic, copy) NSString * promiseStore;

	/**
邀约结束，是否确认 0：未确认 1：已确认
 */
@property (nonatomic, assign) int isConfirm;

	/**
约定地址
 */
@property (nonatomic, copy) NSString * promiseAddress;

	/**
流程显示文字
 */
@property (nonatomic, copy) NSString * processShowText;

	/**
是否已经评价 0：未评价 1：已评价
 */
@property (nonatomic, assign) int isEvaluate;

	/**
约定的经度
 */
@property (nonatomic, assign) double longitude;

 +(NSMutableArray<AppPromiseOrderInfoVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppPromiseOrderInfoVOModel*>*)list;

 +(AppPromiseOrderInfoVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppPromiseOrderInfoVOModel*) source target:(AppPromiseOrderInfoVOModel*)target;

@end

NS_ASSUME_NONNULL_END
