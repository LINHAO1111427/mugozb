//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
 * 发送红包
*/
@interface RedPacketController_sendRedPacket : NSObject 


 +(RedPacketController_sendRedPacket*)getFromDict:(NSDictionary*)dict;

 +(NSMutableArray<RedPacketController_sendRedPacket*>*)getFromArr:(NSArray*)list;


	
	/**
在房间红包时必填,其他填-1
 */
@property (nonatomic, assign) int64_t anchorId;


	
	/**
货币类型 1：金币 2：积分
 */
@property (nonatomic, assign) int currencyType;


	
	/**
直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 8:家族 9:私聊 10：粉丝团
 */
@property (nonatomic, assign) int liveType;


	
	/**
收红包的用户id(指定红包时必传,其他传空字符串)
 */
@property (nonatomic, copy) NSString * otherUserId;


	
	/**
红包数量
 */
@property (nonatomic, assign) int redPacketAmount;


	
	/**
红包发送的范围 1:房间红包(直播间内/一对一/聊天家族) 2:指定红包
 */
@property (nonatomic, assign) int redPacketRange;


	
	/**
红包类型 1:普通红包
 */
@property (nonatomic, assign) int redPacketType;


	
	/**
房间号
 */
@property (nonatomic, assign) int64_t roomId;


	
	/**
直播标识
 */
@property (nonatomic, copy) NSString * showId;


	
	/**
红包总价值
 */
@property (nonatomic, assign) double totalValue;

@end

NS_ASSUME_NONNULL_END
