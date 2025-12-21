//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
邀请列表
 */
@interface UserInvitationVOModel : NSObject 


	/**
累计获取的佣金
 */
@property (nonatomic, assign) double totalAmount;

	/**
累计充值金额
 */
@property (nonatomic, assign) double totalCharge;

	/**
绑定时间
 */
@property (nonatomic,copy) NSDate * createTime;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
累计获取的佣金(映票)
 */
@property (nonatomic, assign) double totalTicket;

	/**
用户名
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<UserInvitationVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserInvitationVOModel*>*)list;

 +(UserInvitationVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(UserInvitationVOModel*) source target:(UserInvitationVOModel*)target;

@end

NS_ASSUME_NONNULL_END
