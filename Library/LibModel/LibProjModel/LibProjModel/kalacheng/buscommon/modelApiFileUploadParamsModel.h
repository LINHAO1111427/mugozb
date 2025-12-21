//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP轩嗵云获取token请求参数
 */
@interface modelApiFileUploadParamsModel : NSObject 


	/**
图片使用场景 1:用户图片 2:动态圈图片 3:动态圈视频 4:用户视频 :5用户语音
 */
@property (nonatomic, assign) int scene;

 +(NSMutableArray<modelApiFileUploadParamsModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<modelApiFileUploadParamsModel*>*)list;

 +(modelApiFileUploadParamsModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(modelApiFileUploadParamsModel*) source target:(modelApiFileUploadParamsModel*)target;

@end

NS_ASSUME_NONNULL_END
