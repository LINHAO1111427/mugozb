//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
一对一二级分类vo
 */
@interface OooTwoClassifyVOModel : NSObject 


	/**
修改时间
 */
@property (nonatomic,copy) NSDate * upTime;

	/**
创建时间
 */
@property (nonatomic,copy) NSDate * addTime;

	/**
二级分类名称
 */
@property (nonatomic, copy) NSString * oooTowTypeName;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
是否启用 1:启用 0：不启用
 */
@property (nonatomic, assign) int isEnable;

	/**
一级分类id(关联app_live_channel表)
 */
@property (nonatomic, assign) int64_t oneClassifyId;

 +(NSMutableArray<OooTwoClassifyVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<OooTwoClassifyVOModel*>*)list;

 +(OooTwoClassifyVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(OooTwoClassifyVOModel*) source target:(OooTwoClassifyVOModel*)target;

@end

NS_ASSUME_NONNULL_END
