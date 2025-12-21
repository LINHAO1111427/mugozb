//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP直播间踢人
 */
@interface ApiKickModel : NSObject 


	/**
会员等级
 */
@property (nonatomic, copy) NSString * userLevel;

	/**
个性签名
 */
@property (nonatomic, copy) NSString * signature;

	/**
性别；0：保密，1：男；2：女
 */
@property (nonatomic, assign) int sex;

	/**
禁言添加时间
 */
@property (nonatomic,copy) NSDate * startTime;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
禁言结束时间
 */
@property (nonatomic,copy) NSDate * endTime;

	/**
主播等级
 */
@property (nonatomic, copy) NSString * anchorLevel;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

	/**
用户名
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<ApiKickModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiKickModel*>*)list;

 +(ApiKickModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiKickModel*) source target:(ApiKickModel*)target;

@end

NS_ASSUME_NONNULL_END
