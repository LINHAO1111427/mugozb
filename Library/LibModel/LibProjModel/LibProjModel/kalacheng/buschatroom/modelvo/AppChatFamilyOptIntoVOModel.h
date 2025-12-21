//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
聊天家族操作信息VO
 */
@interface AppChatFamilyOptIntoVOModel : NSObject 


	/**
家族角色 1：族长 2：副族长 3：长老 4：成员
 */
@property (nonatomic, assign) int familyRole;

	/**
广场禁言特权（低于或等于对方贵族等级，也相当与没有） 0：没有 1：有
 */
@property (nonatomic, assign) int isSquareMute;

	/**
对方家族角色 1：族长 2：副族长 3：长老 4：成员
 */
@property (nonatomic, assign) int toFamilyRole;

	/**
踢人功能 0：没有 1：有
 */
@property (nonatomic, assign) int isSquareKickPeople;

	/**
对方的禁言状态 1：被禁言 0：没有禁言
 */
@property (nonatomic, assign) int muteStatus;

 +(NSMutableArray<AppChatFamilyOptIntoVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppChatFamilyOptIntoVOModel*>*)list;

 +(AppChatFamilyOptIntoVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppChatFamilyOptIntoVOModel*) source target:(AppChatFamilyOptIntoVOModel*)target;

@end

NS_ASSUME_NONNULL_END
