//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiUserInfoModel;
NS_ASSUME_NONNULL_BEGIN




/**
我的账户相关
 */
@interface UserInfoHomeVOModel : NSObject 


	/**
用户信息
 */
@property (strong, nonatomic) ApiUserInfoModel* userInfo;

	/**
关注状态 0:未关注， 1：已关注
 */
@property (nonatomic, assign) int isAttentionUser;

	/**
一对一用户语音
 */
@property (nonatomic, copy) NSString * oooVoice;

	/**
svip 图标
 */
@property (nonatomic, copy) NSString * svipIcon;

	/**
距离
 */
@property (nonatomic, assign) double distance;

	/**
前端显示的状态字段：0:离线 1:忙碌 2:在线 3:通话中 4:看直播 5:匹配中 6:直播中 7:离开
 */
@property (nonatomic, assign) int showStatus;

	/**
展示声音时长
 */
@property (nonatomic, assign) int64_t oooVoiceTime;

	/**
主播星级
 */
@property (nonatomic, assign) int starGrade;

	/**
贵族剩余天数
 */
@property (nonatomic, assign) int64_t nobleExpireDay;

 +(NSMutableArray<UserInfoHomeVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserInfoHomeVOModel*>*)list;

 +(UserInfoHomeVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(UserInfoHomeVOModel*) source target:(UserInfoHomeVOModel*)target;

@end

NS_ASSUME_NONNULL_END
