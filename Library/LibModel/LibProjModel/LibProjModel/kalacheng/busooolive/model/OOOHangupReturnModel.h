//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
挂断响应
 */
@interface OOOHangupReturnModel : NSObject 


	/**
挂断方id
 */
@property (nonatomic, assign) int64_t callUpUid;

	/**
挂断方为观众时的支出金额
 */
@property (nonatomic, assign) double payCoin;

	/**
挂断方的角色 0用户 1主播 2副播
 */
@property (nonatomic, assign) int role;

	/**
挂断原因:1:正常挂断 2:直播云异常 11:费用不足 12:对方网络断开 13:超时自动撤销 22:用户掉线拒接 31:直播被封禁
 */
@property (nonatomic, assign) int hangupResion;

	/**
挂断方为主播或副播时的获得收入
 */
@property (nonatomic, assign) double totalCoin;

	/**
挂断方头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
(付费方)免费通话时长
 */
@property (nonatomic, assign) int freeCallDuration;

	/**
是否已经接通
 */
@property (nonatomic, assign) int isTalked;

	/**
贵族优惠类型信息
 */
@property (nonatomic, copy) NSString * vipGradeMsg;

	/**
通话时长
 */
@property (nonatomic, assign) int64_t callTime;

	/**
贵族优惠金额
 */
@property (nonatomic, assign) double vipCount;

	/**
挂断方用户名
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<OOOHangupReturnModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OOOHangupReturnModel*>*)list;

 +(OOOHangupReturnModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(OOOHangupReturnModel*) source target:(OOOHangupReturnModel*)target;

@end

NS_ASSUME_NONNULL_END
