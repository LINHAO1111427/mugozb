//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
一对一房间用户的返回实体
 */
@interface OTMAssisRetModel : NSObject 


	/**
用户的麦克风状态 0:关闭 1:开启
 */
@property (nonatomic, assign) int hostVolumed;

	/**
是否被禁言 0:未禁言 1:已禁言
 */
@property (nonatomic, assign) int isShutUp;

	/**
用户的角色 0:普通用户 1:主播
 */
@property (nonatomic, assign) int role;

	/**
用户在房间中的角色 0:用户 1:主播 2:副播
 */
@property (nonatomic, assign) int userToRoomRole;

	/**
主播粉丝团群聊id
 */
@property (nonatomic, assign) int64_t groupId;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
贵族等级
 */
@property (nonatomic, assign) int nobleGrade;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

 +(NSMutableArray<OTMAssisRetModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OTMAssisRetModel*>*)list;

 +(OTMAssisRetModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(OTMAssisRetModel*) source target:(OTMAssisRetModel*)target;

@end

NS_ASSUME_NONNULL_END
