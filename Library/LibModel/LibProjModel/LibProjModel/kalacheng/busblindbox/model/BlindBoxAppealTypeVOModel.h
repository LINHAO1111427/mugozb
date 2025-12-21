//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
投诉列表
 */
@interface BlindBoxAppealTypeVOModel : NSObject 


	/**
修改时间
 */
@property (nonatomic,copy) NSDate * upTime;

	/**
创建时间
 */
@property (nonatomic,copy) NSDate * addTime;

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

 +(NSMutableArray<BlindBoxAppealTypeVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<BlindBoxAppealTypeVOModel*>*)list;

 +(BlindBoxAppealTypeVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(BlindBoxAppealTypeVOModel*) source target:(BlindBoxAppealTypeVOModel*)target;

@end

NS_ASSUME_NONNULL_END
