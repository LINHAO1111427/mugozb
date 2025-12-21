//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
分享配置
 */
@interface ApiShareConfigModel : NSObject 


	/**
分享标题
 */
@property (nonatomic, copy) NSString * shareTitle;

	/**
logo
 */
@property (nonatomic, copy) NSString * logo;

	/**
分享话术
 */
@property (nonatomic, copy) NSString * shareDes;

	/**
下载地址
 */
@property (nonatomic, copy) NSString * url;

 +(NSMutableArray<ApiShareConfigModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiShareConfigModel*>*)list;

 +(ApiShareConfigModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiShareConfigModel*) source target:(ApiShareConfigModel*)target;

@end

NS_ASSUME_NONNULL_END
