//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
等级特权
 */
@interface AppGradePrivilegeDTOModel : NSObject 


	/**
等级
 */
@property (nonatomic, assign) int grade;

	/**
特权名称
 */
@property (nonatomic, copy) NSString * name;

	/**
logo
 */
@property (nonatomic, copy) NSString * logo;

 +(NSMutableArray<AppGradePrivilegeDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppGradePrivilegeDTOModel*>*)list;

 +(AppGradePrivilegeDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppGradePrivilegeDTOModel*) source target:(AppGradePrivilegeDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
