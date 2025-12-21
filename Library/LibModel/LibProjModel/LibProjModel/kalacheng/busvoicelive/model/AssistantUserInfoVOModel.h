//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
语音在麦位上的用户信息
 */
@interface AssistantUserInfoVOModel : NSObject 


	/**
财富等级图片
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

	/**
麦序编号
 */
@property (nonatomic, assign) int no;

	/**
性别 0:未设置 1:男 2:女
 */
@property (nonatomic, assign) int sex;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
贵族勋章
 */
@property (nonatomic, copy) NSString * nobleMedal;

	/**
禁止说话 1:是 0:否 默认0
 */
@property (nonatomic, assign) int noTalking;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
贵族等级图片
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
开关麦状态 0:关麦 1:开麦(音量)
 */
@property (nonatomic, assign) int onOffState;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
是否是主持人 0：不是 1：是
 */
@property (nonatomic, assign) int isPresenter;

	/**
等级图片
 */
@property (nonatomic, copy) NSString * gradeImg;

	/**
年龄
 */
@property (nonatomic, assign) int age;

 +(NSMutableArray<AssistantUserInfoVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AssistantUserInfoVOModel*>*)list;

 +(AssistantUserInfoVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AssistantUserInfoVOModel*) source target:(AssistantUserInfoVOModel*)target;

@end

NS_ASSUME_NONNULL_END
