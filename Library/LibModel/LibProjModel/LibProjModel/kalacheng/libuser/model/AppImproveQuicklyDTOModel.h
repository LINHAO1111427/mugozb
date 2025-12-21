//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
快速提升配置
 */
@interface AppImproveQuicklyDTOModel : NSObject 


	/**
名称
 */
@property (nonatomic, copy) NSString * name;

	/**
logo
 */
@property (nonatomic, copy) NSString * logo;

	/**
简介描述
 */
@property (nonatomic, copy) NSString * desr;

 +(NSMutableArray<AppImproveQuicklyDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppImproveQuicklyDTOModel*>*)list;

 +(AppImproveQuicklyDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppImproveQuicklyDTOModel*) source target:(AppImproveQuicklyDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
