//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP点亮发送消息
 */
@interface ApiLightSenderModel : NSObject 


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
状态1成功2失败
 */
@property (nonatomic, assign) int code;

	/**
状态描述
 */
@property (nonatomic, copy) NSString * msg;

 +(NSMutableArray<ApiLightSenderModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiLightSenderModel*>*)list;

 +(ApiLightSenderModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiLightSenderModel*) source target:(ApiLightSenderModel*)target;

@end

NS_ASSUME_NONNULL_END
