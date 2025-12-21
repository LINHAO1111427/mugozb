//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
聊天家族消息置顶VO
 */
@interface AppChatFamilyMsgTopVOModel : NSObject 


	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
性别 0:未设置 1:男 2:女 
 */
@property (nonatomic, assign) int sex;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
用户名
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
是否显示 0：隐藏 1：显示
 */
@property (nonatomic, assign) int isShow;

	/**
家族id
 */
@property (nonatomic, assign) int64_t familyId;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
等级图片
 */
@property (nonatomic, copy) NSString * gradeImg;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
消息内容
 */
@property (nonatomic, copy) NSString * topMsgContent;

	/**
年龄
 */
@property (nonatomic, assign) int age;

 +(NSMutableArray<AppChatFamilyMsgTopVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppChatFamilyMsgTopVOModel*>*)list;

 +(AppChatFamilyMsgTopVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppChatFamilyMsgTopVOModel*) source target:(AppChatFamilyMsgTopVOModel*)target;

@end

NS_ASSUME_NONNULL_END
