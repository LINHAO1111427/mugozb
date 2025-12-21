//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP轩嗵云响应
 */
@interface ApiQinuRespModel : NSObject 


	/**
文件名
 */
@property (nonatomic, copy) NSString * fileName;

	/**
轩嗵云域名
 */
@property (nonatomic, copy) NSString * rootPath;

 +(NSMutableArray<ApiQinuRespModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiQinuRespModel*>*)list;

 +(ApiQinuRespModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiQinuRespModel*) source target:(ApiQinuRespModel*)target;

@end

NS_ASSUME_NONNULL_END
