//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
电视剧分类VO
 */
@interface TelevisionVideoTypeVOModel : NSObject 


	/**
排序字段
 */
@property (nonatomic, assign) int sequence;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
电视剧分类名称
 */
@property (nonatomic, copy) NSString * televisionVideoTypeName;

	/**
是否启用 1:启用 0：不启用
 */
@property (nonatomic, assign) int isEnable;

 +(NSMutableArray<TelevisionVideoTypeVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<TelevisionVideoTypeVOModel*>*)list;

 +(TelevisionVideoTypeVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(TelevisionVideoTypeVOModel*) source target:(TelevisionVideoTypeVOModel*)target;

@end

NS_ASSUME_NONNULL_END
