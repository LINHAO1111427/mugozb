//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiUserIndexNodeModel;
NS_ASSUME_NONNULL_BEGIN




/**
APP用户中心接口响应
 */
@interface ApiUserIndexRespModel : NSObject 


	/**
生日
 */
@property (nonatomic, copy) NSString * birthday;

	/**
8服务热线等2
 */
@property (nonatomic, strong) NSMutableArray<ApiUserIndexNodeModel*>* userlist;

	/**
地址
 */
@property (nonatomic, copy) NSString * address;

	/**
签名
 */
@property (nonatomic, copy) NSString * signature;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * user_name;

	/**
性别；0：保密，1：男；2：女
 */
@property (nonatomic, assign) int sex;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
6设置等
 */
@property (nonatomic, strong) NSMutableArray<ApiUserIndexNodeModel*>* setList;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

	/**
主播等级
 */
@property (nonatomic, copy) NSString * anchor_level;

	/**
用户等级
 */
@property (nonatomic, copy) NSString * user_level;

	/**
动态
 */
@property (nonatomic, strong) NSMutableArray<ApiUserIndexNodeModel*>* infoList;

	/**
封面图
 */
@property (nonatomic, copy) NSString * live_thumb;

 +(NSMutableArray<ApiUserIndexRespModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserIndexRespModel*>*)list;

 +(ApiUserIndexRespModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiUserIndexRespModel*) source target:(ApiUserIndexRespModel*)target;

@end

NS_ASSUME_NONNULL_END
