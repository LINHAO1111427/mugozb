//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP用户关注,粉丝,浏览记录
 */
@interface ApiUserAttenModel : NSObject 


	/**
财富等级图片
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

	/**
角色 0:普通用户 1:主播
 */
@property (nonatomic, assign) int role;

	/**
关注时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 */
@property (nonatomic, assign) int liveType;

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
房间id
 */
@property (nonatomic, assign) int64_t roomId;

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

 +(NSMutableArray<ApiUserAttenModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserAttenModel*>*)list;

 +(ApiUserAttenModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiUserAttenModel*) source target:(ApiUserAttenModel*)target;

@end

NS_ASSUME_NONNULL_END
