//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
勋章
 */
@interface AppMedalDTOModel : NSObject 


	/**
勋章logo
 */
@property (nonatomic, copy) NSString * medalLogo;

	/**
勋章名称
 */
@property (nonatomic, copy) NSString * name;

	/**
勋章级别
 */
@property (nonatomic, assign) int lv;

	/**
简介描述
 */
@property (nonatomic, copy) NSString * desr;

 +(NSMutableArray<AppMedalDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppMedalDTOModel*>*)list;

 +(AppMedalDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppMedalDTOModel*) source target:(AppMedalDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
