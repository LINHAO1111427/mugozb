//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
聊天家族禁言VO
 */
@interface AppChatFamilyMuteVOModel : NSObject 


	/**
家族id
 */
@property (nonatomic, assign) int64_t familyId;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
禁言到期时间
 */
@property (nonatomic,copy) NSDate * expireTime;

	/**
禁言时长
 */
@property (nonatomic, assign) int muteDuration;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
等级图片
 */
@property (nonatomic, copy) NSString * gradeImg;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

 +(NSMutableArray<AppChatFamilyMuteVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppChatFamilyMuteVOModel*>*)list;

 +(AppChatFamilyMuteVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppChatFamilyMuteVOModel*) source target:(AppChatFamilyMuteVOModel*)target;

@end

NS_ASSUME_NONNULL_END
