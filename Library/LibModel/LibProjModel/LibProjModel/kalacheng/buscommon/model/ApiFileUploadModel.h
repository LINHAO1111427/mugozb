//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiQinuRespModel;
NS_ASSUME_NONNULL_BEGIN




/**
APP轩嗵云获取token响应
 */
@interface ApiFileUploadModel : NSObject 


	/**
accessKeyId
 */
@property (nonatomic, copy) NSString * accessKeyId;

	/**
secretKeyId
 */
@property (nonatomic, copy) NSString * secretKeyId;

	/**
云服务器地址(访问地址)
 */
@property (nonatomic, copy) NSString * yunServerUrl;

	/**
空间名称
 */
@property (nonatomic, copy) NSString * obsName;

	/**
区域z0华东,z1华北,z2华南,na0北美,as0东南亚(区域)
 */
@property (nonatomic, copy) NSString * zone;

	/**
图片信息
 */
@property (nonatomic, strong) NSMutableArray<ApiQinuRespModel*>* filePath;

	/**
轩嗵云token
 */
@property (nonatomic, copy) NSString * token;

 +(NSMutableArray<ApiFileUploadModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiFileUploadModel*>*)list;

 +(ApiFileUploadModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiFileUploadModel*) source target:(ApiFileUploadModel*)target;

@end

NS_ASSUME_NONNULL_END
