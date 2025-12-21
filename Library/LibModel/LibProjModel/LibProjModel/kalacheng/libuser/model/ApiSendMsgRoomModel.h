//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP直播间发送文字消息
 */
@interface ApiSendMsgRoomModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
房间号
 */
@property (nonatomic, assign) int64_t roomId;

	/**
发送者名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
发送者id
 */
@property (nonatomic, assign) int64_t uid;

	/**
推送内容
 */
@property (nonatomic, copy) NSString * content;

	/**
用户等级
 */
@property (nonatomic, copy) NSString * level;

	/**
禁言/踢出时长
 */
@property (nonatomic, assign) int time;

	/**
点亮次数
 */
@property (nonatomic, assign) int heart;

	/**
0系统消息1是普通消息  2弹幕消息
 */
@property (nonatomic, assign) int type;

	/**
靓号
 */
@property (nonatomic, copy) NSString * liangName;

	/**
是否为VIP0不是1是vip
 */
@property (nonatomic, assign) int vipType;

	/**
是否为守护0不是1是守护
 */
@property (nonatomic, assign) int guardType;

	/**
是否是管理0不是1是管理
 */
@property (nonatomic, assign) int manager;

	/**
直播间名称
 */
@property (nonatomic, copy) NSString * liveNiceName;

	/**
是否有直播购 0没有直播购  1有直播购
 */
@property (nonatomic, assign) int liveFunction;

 +(NSMutableArray<ApiSendMsgRoomModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiSendMsgRoomModel*>*)list;

 +(ApiSendMsgRoomModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiSendMsgRoomModel*) source target:(ApiSendMsgRoomModel*)target;

@end

NS_ASSUME_NONNULL_END
