//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户坐骑表
 */
@interface AppUsersCarModel : NSObject 


	/**
坐骑头像
 */
@property (nonatomic, copy) NSString * thumb;

	/**
添加时间
 */
@property (nonatomic,copy) NSDate * addtime;

	/**
坐骑名称
 */
@property (nonatomic, copy) NSString * name;

	/**
到期时间
 */
@property (nonatomic,copy) NSDate * endtime;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userid;

	/**
坐骑ID
 */
@property (nonatomic, assign) int carid;

	/**
是否启用
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<AppUsersCarModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUsersCarModel*>*)list;

 +(AppUsersCarModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppUsersCarModel*) source target:(AppUsersCarModel*)target;

@end

NS_ASSUME_NONNULL_END
