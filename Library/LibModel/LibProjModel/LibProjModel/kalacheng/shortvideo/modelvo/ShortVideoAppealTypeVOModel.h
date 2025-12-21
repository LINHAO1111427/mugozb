//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
短视频举报类型VO
 */
@interface ShortVideoAppealTypeVOModel : NSObject 


	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
举报类型名称
 */
@property (nonatomic, copy) NSString * appealTypeName;

	/**
是否启用 1:启用 0：不启用
 */
@property (nonatomic, assign) int isEnable;

 +(NSMutableArray<ShortVideoAppealTypeVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShortVideoAppealTypeVOModel*>*)list;

 +(ShortVideoAppealTypeVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShortVideoAppealTypeVOModel*) source target:(ShortVideoAppealTypeVOModel*)target;

@end

NS_ASSUME_NONNULL_END
