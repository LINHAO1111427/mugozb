//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
加入聊天室消息VO
 */
@interface AppJoinChatRoomMsgVOModel : NSObject 


	/**
房间id（群聊id）
 */
@property (nonatomic, assign) int64_t familyId;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * userAvatar;

	/**
性别 0:未设置 1:男 2:女
 */
@property (nonatomic, assign) int sex;

	/**
年龄
 */
@property (nonatomic, assign) int age;

	/**
财富等级图片
 */
@property (nonatomic, copy) NSString * wealthGradeImg;

	/**
贵族头像框
 */
@property (nonatomic, copy) NSString * nobleAvatarFrame;

	/**
贵族名称
 */
@property (nonatomic, copy) NSString * nobleName;

	/**
贵族等级
 */
@property (nonatomic, assign) int nobleGrade;

	/**
贵族勋章
 */
@property (nonatomic, copy) NSString * nobleMedal;

 +(NSMutableArray<AppJoinChatRoomMsgVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppJoinChatRoomMsgVOModel*>*)list;

 +(AppJoinChatRoomMsgVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppJoinChatRoomMsgVOModel*) source target:(AppJoinChatRoomMsgVOModel*)target;

@end

NS_ASSUME_NONNULL_END
