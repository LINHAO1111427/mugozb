//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
守护
 */
@interface GuardUserVOModel : NSObject 


	/**
开始守护时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
被守护用户头像
 */
@property (nonatomic, copy) NSString * anchorIdImg;

	/**
消费金额
 */
@property (nonatomic, assign) double consumptionAmount;

	/**
被守护用户ID
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
主播名称
 */
@property (nonatomic, copy) NSString * anchorName;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userHeadImg;

	/**
欠费天数
 */
@property (nonatomic, assign) int64_t freeDay;

	/**
是否过期：0.未过期，1.已过期，-1.未守护过
 */
@property (nonatomic, assign) int64_t isOverdue;

	/**
剩余天数
 */
@property (nonatomic, assign) int64_t leftDay;

	/**
已守护天数
 */
@property (nonatomic, assign) int64_t guardDay;

	/**
结束守护时间
 */
@property (nonatomic,copy) NSDate * endTime;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<GuardUserVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GuardUserVOModel*>*)list;

 +(GuardUserVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GuardUserVOModel*) source target:(GuardUserVOModel*)target;

@end

NS_ASSUME_NONNULL_END
