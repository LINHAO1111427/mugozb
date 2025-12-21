//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
等级的基本信息
 */
@interface AppGradeBasisInfoModel : NSObject 


	/**
等级图标
 */
@property (nonatomic, copy) NSString * gradeIcon;

	/**
等级
 */
@property (nonatomic, assign) int grade;

	/**
等级名称
 */
@property (nonatomic, copy) NSString * name;

	/**
等级id
 */
@property (nonatomic, assign) int64_t id_field;

	/**
是否启用 1:启用 0：关闭
 */
@property (nonatomic, assign) int isEnable;

 +(NSMutableArray<AppGradeBasisInfoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppGradeBasisInfoModel*>*)list;

 +(AppGradeBasisInfoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppGradeBasisInfoModel*) source target:(AppGradeBasisInfoModel*)target;

@end

NS_ASSUME_NONNULL_END
