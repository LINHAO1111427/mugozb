//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP版本控制返回值
 */
@interface ApiVersionModel : NSObject 


	/**
描述
 */
@property (nonatomic, copy) NSString * des;

	/**
是否强制更新,-1:不需要更新,0:非强制,1:强制
 */
@property (nonatomic, assign) int isConstraint;

	/**
版本号
 */
@property (nonatomic, copy) NSString * versionNo;

	/**
下载地址
 */
@property (nonatomic, copy) NSString * url;

	/**
app版本code
 */
@property (nonatomic, assign) int versionCode;

	/**
分享地址
 */
@property (nonatomic, copy) NSString * shareAddress;

 +(NSMutableArray<ApiVersionModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiVersionModel*>*)list;

 +(ApiVersionModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiVersionModel*) source target:(ApiVersionModel*)target;

@end

NS_ASSUME_NONNULL_END
