//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP购买贵宾席
 */
@interface ApiBeautifulNumberModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t serialVersionUID;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
用户名
 */
@property (nonatomic, copy) NSString * username;

	/**
用户id
 */
@property (nonatomic, assign) int64_t uid;

	/**
靓号号码
 */
@property (nonatomic, copy) NSString * number;

 +(NSMutableArray<ApiBeautifulNumberModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiBeautifulNumberModel*>*)list;

 +(ApiBeautifulNumberModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiBeautifulNumberModel*) source target:(ApiBeautifulNumberModel*)target;

@end

NS_ASSUME_NONNULL_END
