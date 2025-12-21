//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户禁言信息
 */
@interface ApiShutUpModel : NSObject 


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

 +(NSMutableArray<ApiShutUpModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiShutUpModel*>*)list;

 +(ApiShutUpModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiShutUpModel*) source target:(ApiShutUpModel*)target;

@end

NS_ASSUME_NONNULL_END
