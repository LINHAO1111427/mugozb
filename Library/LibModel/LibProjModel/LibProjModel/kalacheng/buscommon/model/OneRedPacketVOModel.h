//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
第一个红包 返回VO
 */
@interface OneRedPacketVOModel : NSObject 


	/**
货币类型 1：金币 2：积分
 */
@property (nonatomic, assign) int currencyType;

	/**
发送红包用户id
 */
@property (nonatomic, assign) int64_t sendUserId;

	/**
红包总价值
 */
@property (nonatomic, assign) double totalValue;

	/**
扣除后红包总价值
 */
@property (nonatomic, assign) double deductionAfterTotalValue;

	/**
红包发送的范围 1:房间红包(直播间内/一对一) 2:指定红包
 */
@property (nonatomic, assign) int redPacketRange;

	/**
红包的数量
 */
@property (nonatomic, assign) int redPacketAmount;

	/**
发送红包用户名
 */
@property (nonatomic, copy) NSString * sendUserName;

	/**
是否领取到了 0:没有领到 1:领到了
 */
@property (nonatomic, assign) int isReceive;

	/**
领取了多少
 */
@property (nonatomic, assign) double myReceivedValue;

	/**
红包id
 */
@property (nonatomic, assign) int64_t redPacketId;

	/**
发送红包的用户头像
 */
@property (nonatomic, copy) NSString * sendUserAvatar;

 +(NSMutableArray<OneRedPacketVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OneRedPacketVOModel*>*)list;

 +(OneRedPacketVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(OneRedPacketVOModel*) source target:(OneRedPacketVOModel*)target;

@end

NS_ASSUME_NONNULL_END
