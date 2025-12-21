//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
null
 */
@interface ApiBaseEntityModel : NSObject 


	/**
状态描述
 */
@property (nonatomic, copy) NSString * msg;

	/**
状态1成功2失败
 */
@property (nonatomic, assign) int code;

 +(NSMutableArray<ApiBaseEntityModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiBaseEntityModel*>*)list;

 +(ApiBaseEntityModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiBaseEntityModel*) source target:(ApiBaseEntityModel*)target;

@end

NS_ASSUME_NONNULL_END
