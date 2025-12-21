//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
动态返回基本信息
 */
@interface MyInfoDynamicCircleModel : NSObject 


	/**
动态展示图
 */
@property (nonatomic, copy) NSString * dynamicThumb;

 +(NSMutableArray<MyInfoDynamicCircleModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<MyInfoDynamicCircleModel*>*)list;

 +(MyInfoDynamicCircleModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(MyInfoDynamicCircleModel*) source target:(MyInfoDynamicCircleModel*)target;

@end

NS_ASSUME_NONNULL_END
