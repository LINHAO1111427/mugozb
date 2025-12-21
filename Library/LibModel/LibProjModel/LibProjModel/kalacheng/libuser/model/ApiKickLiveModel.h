//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP直播间踢人
 */
@interface ApiKickLiveModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
房间号
 */
@property (nonatomic, assign) int64_t roomId;

	/**
踢人用户id)
 */
@property (nonatomic, assign) int64_t uid;

	/**
被踢用户id
 */
@property (nonatomic, assign) int64_t touid;

	/**
被踢人名称
 */
@property (nonatomic, copy) NSString * toUserName;

	/**
内容
 */
@property (nonatomic, copy) NSString * content;

	/**
离开后房间人数
 */
@property (nonatomic, assign) int watchNumber;

	/**
状态1成功2失败
 */
@property (nonatomic, assign) int code;

	/**
状态描述
 */
@property (nonatomic, copy) NSString * msg;

 +(NSMutableArray<ApiKickLiveModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiKickLiveModel*>*)list;

 +(ApiKickLiveModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiKickLiveModel*) source target:(ApiKickLiveModel*)target;

@end

NS_ASSUME_NONNULL_END
