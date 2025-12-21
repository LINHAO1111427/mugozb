//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
红包返回VO
 */
@interface RedPacketVOModel : NSObject 


	/**
货币类型 1：金币 2：积分
 */
@property (nonatomic, assign) int currencyType;

	/**
扣除后红包总价值
 */
@property (nonatomic, assign) double deductionAfterTotalValue;

	/**
红包添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 8:群聊 9:私聊
 */
@property (nonatomic, assign) int liveType;

	/**
已领取红包总价值
 */
@property (nonatomic, assign) double receivedValue;

	/**
红包类型 1:普通红包
 */
@property (nonatomic, assign) int redPacketType;

	/**
房间id
 */
@property (nonatomic, assign) int64_t roomId;

	/**
用户id
 */
@property (nonatomic, assign) int64_t sendUserId;

	/**
扣除总数量
 */
@property (nonatomic, assign) double deductionTotalValue;

	/**
已领取红包数量
 */
@property (nonatomic, assign) int remainingAmount;

	/**
直播标识
 */
@property (nonatomic, copy) NSString * showId;

	/**
领红包的用户头像
 */
@property (nonatomic, copy) NSString * otherUserAvatar;

	/**
发送红包用户名
 */
@property (nonatomic, copy) NSString * sendUserName;

	/**
红包到期时间
 */
@property (nonatomic,copy) NSDate * expireDate;

	/**
红包扣除比例（小数）
 */
@property (nonatomic, assign) double deductionRatio;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
接收用户的id,中间用 , 隔开
 */
@property (nonatomic, copy) NSString * otherUserId;

	/**
红包总价值
 */
@property (nonatomic, assign) double totalValue;

	/**
红包的状态 1:领取中 2:领取完了 3:余额退还
 */
@property (nonatomic, assign) int redPacketStatus;

	/**
红包数量
 */
@property (nonatomic, assign) int redPacketAmount;

	/**
是否领取到了 0:未领取 1:领到了(表示本次打开红包) 2:已经领过了 3:红包领取完了 4：红包过期了
 */
@property (nonatomic, assign) int isReceive;

	/**
主播id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
红包发送的范围 1:房间红包(直播间内/一对一) 2:指定红包
 */
@property (nonatomic, assign) int redPacketRange;

	/**
领红包用户名
 */
@property (nonatomic, copy) NSString * otherUserName;

	/**
领取了多少
 */
@property (nonatomic, assign) double myReceivedValue;

	/**
发送红包的用户头像
 */
@property (nonatomic, copy) NSString * sendUserAvatar;

 +(NSMutableArray<RedPacketVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<RedPacketVOModel*>*)list;

 +(RedPacketVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(RedPacketVOModel*) source target:(RedPacketVOModel*)target;

@end

NS_ASSUME_NONNULL_END
