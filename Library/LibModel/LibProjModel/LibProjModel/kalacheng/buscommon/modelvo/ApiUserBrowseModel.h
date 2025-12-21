//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP用户关注,粉丝,浏览记录
 */
@interface ApiUserBrowseModel : NSObject 


	/**
财富等级图片
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

	/**
角色 0:普通用户 1:主播
 */
@property (nonatomic, assign) int role;

	/**
浏览时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
性别；0：保密，1：男；2：女
 */
@property (nonatomic, assign) int sex;

	/**
用户等级图片
 */
@property (nonatomic, copy) NSString * userGradeImg;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
贵族等级图片
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
主播等级图片
 */
@property (nonatomic, copy) NSString * anchorGradeImg;

	/**
年龄
 */
@property (nonatomic, assign) int age;

	/**
关注状态 0:未关注 1:已关注
 */
@property (nonatomic, assign) int status;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<ApiUserBrowseModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserBrowseModel*>*)list;

 +(ApiUserBrowseModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiUserBrowseModel*) source target:(ApiUserBrowseModel*)target;

@end

NS_ASSUME_NONNULL_END
