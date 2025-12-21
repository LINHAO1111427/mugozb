//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户基础信息表
 */
@interface AppUserAvatarModel : NSObject 


	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
主播粉丝团群聊id
 */
@property (nonatomic, assign) int64_t groupId;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

 +(NSMutableArray<AppUserAvatarModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserAvatarModel*>*)list;

 +(AppUserAvatarModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppUserAvatarModel*) source target:(AppUserAvatarModel*)target;

@end

NS_ASSUME_NONNULL_END
