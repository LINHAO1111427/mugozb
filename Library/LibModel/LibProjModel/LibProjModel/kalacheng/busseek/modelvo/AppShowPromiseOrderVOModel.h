//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
我的档期订单列表
 */
@interface AppShowPromiseOrderVOModel : NSObject 


	/**
邀约时长（最多6小时）
 */
@property (nonatomic, assign) int promiseDuration;

	/**
技能名称
 */
@property (nonatomic, copy) NSString * skillName;

	/**
邀约结束，是否确认 0：未确认 1：已确认
 */
@property (nonatomic, assign) int isConfirm;

	/**
用户是否发起申诉 0：没有 1：申述中 2：申述处理完成
 */
@property (nonatomic, assign) int isUserAppeal;

	/**
订单总价格
 */
@property (nonatomic, assign) double totalPrice;

	/**
显示的用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
订单状态 1：待回复 2：待见面（未到约定时间）3：已见面（已到约定时间） 4：约会结束（系统约定时间已到） 5:双方确认(或约会完成后超3小时) 6:结算中（等待24小时） 7：订单完结 8：订单已取消 9：主播拒绝
 */
@property (nonatomic, assign) int orderStatus;

	/**
用户在本订单中的角色 1：用户 2：主播
 */
@property (nonatomic, assign) int orderRole;

	/**
显示的用户名
 */
@property (nonatomic, copy) NSString * userName;

	/**
是否已经评价 0：未评价 1：已评价
 */
@property (nonatomic, assign) int isEvaluate;

	/**
订单id
 */
@property (nonatomic, assign) int64_t promiseOrderId;

 +(NSMutableArray<AppShowPromiseOrderVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppShowPromiseOrderVOModel*>*)list;

 +(AppShowPromiseOrderVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppShowPromiseOrderVOModel*) source target:(AppShowPromiseOrderVOModel*)target;

@end

NS_ASSUME_NONNULL_END
