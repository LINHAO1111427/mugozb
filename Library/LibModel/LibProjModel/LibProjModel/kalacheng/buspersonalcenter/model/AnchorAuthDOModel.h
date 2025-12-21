//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
认证信息是否显示
 */
@interface AnchorAuthDOModel : NSObject 


	/**
是否必填 0.非必填，1.必填
 */
@property (nonatomic, assign) int isRequired;

	/**
名称对应标识
 */
@property (nonatomic, copy) NSString * identification;

	/**
名称
 */
@property (nonatomic, copy) NSString * name;

	/**
是否显示 0.不显示，1.显示
 */
@property (nonatomic, assign) int isShow;

 +(NSMutableArray<AnchorAuthDOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AnchorAuthDOModel*>*)list;

 +(AnchorAuthDOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AnchorAuthDOModel*) source target:(AnchorAuthDOModel*)target;

@end

NS_ASSUME_NONNULL_END
