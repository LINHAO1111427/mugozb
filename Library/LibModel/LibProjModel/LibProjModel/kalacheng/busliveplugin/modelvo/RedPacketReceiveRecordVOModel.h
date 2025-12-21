//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
红包的领取记录VO
 */
@interface RedPacketReceiveRecordVOModel : NSObject 


	/**
货币类型 1：金币 2：积分
 */
@property (nonatomic, assign) int currencyType;

	/**
红包总价值
 */
@property (nonatomic, assign) double totalValue;

	/**
领取时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
剩余红包价值
 */
@property (nonatomic, assign) double remainingValue;

	/**
红包数量
 */
@property (nonatomic, assign) int redPacketAmount;

	/**
红包类型 1:普通红包
 */
@property (nonatomic, assign) int redPacketType;

	/**
领取红包的用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
领取红包的用户名
 */
@property (nonatomic, copy) NSString * userName;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

	/**
发送红包的用户id
 */
@property (nonatomic, assign) int64_t sendUserId;

	/**
扣除数量
 */
@property (nonatomic, assign) double deductionValue;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
领取了多少
 */
@property (nonatomic, assign) double myReceivedValue;

	/**
红包id
 */
@property (nonatomic, assign) int64_t redPacketId;

 +(NSMutableArray<RedPacketReceiveRecordVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<RedPacketReceiveRecordVOModel*>*)list;

 +(RedPacketReceiveRecordVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(RedPacketReceiveRecordVOModel*) source target:(RedPacketReceiveRecordVOModel*)target;

@end

NS_ASSUME_NONNULL_END
