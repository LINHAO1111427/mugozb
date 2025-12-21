//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户信息
 */
@interface SimpleUserDTOModel : NSObject 


	/**
小头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
null
 */
@property (nonatomic, assign) int64_t userid;

	/**
昵称
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<SimpleUserDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<SimpleUserDTOModel*>*)list;

 +(SimpleUserDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(SimpleUserDTOModel*) source target:(SimpleUserDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
