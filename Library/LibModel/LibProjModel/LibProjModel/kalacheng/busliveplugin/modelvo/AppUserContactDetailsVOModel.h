//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户联系方式VO（直播间内发送的联系方式，和一对一的没有关系）
 */
@interface AppUserContactDetailsVOModel : NSObject 


	/**
QQ号
 */
@property (nonatomic, copy) NSString * qq;

	/**
最后一次更新时间
 */
@property (nonatomic,copy) NSDate * upTime;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
手机号
 */
@property (nonatomic, copy) NSString * phone;

	/**
微信号
 */
@property (nonatomic, copy) NSString * weChat;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

 +(NSMutableArray<AppUserContactDetailsVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserContactDetailsVOModel*>*)list;

 +(AppUserContactDetailsVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppUserContactDetailsVOModel*) source target:(AppUserContactDetailsVOModel*)target;

@end

NS_ASSUME_NONNULL_END
