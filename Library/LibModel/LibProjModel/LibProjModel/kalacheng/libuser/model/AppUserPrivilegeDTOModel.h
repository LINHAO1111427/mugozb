//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppImproveQuicklyDTOModel;
 @class AppMedalDTOModel;
 @class AppGradePrivilegeDTOModel;
NS_ASSUME_NONNULL_BEGIN




/**
用户经验值
 */
@interface AppUserPrivilegeDTOModel : NSObject 


	/**
用户/财富/主播 快速提升
 */
@property (nonatomic, strong) NSMutableArray<AppImproveQuicklyDTOModel*>* aiqList;

	/**
下一级所需经验
 */
@property (nonatomic, assign) int nextNeedPoint;

	/**
等级
 */
@property (nonatomic, assign) int grade;

	/**
下一级经验值
 */
@property (nonatomic, assign) int nextStartVal;

	/**
用户/财富 勋章
 */
@property (nonatomic, strong) NSMutableArray<AppMedalDTOModel*>* amDTOList;

	/**
头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
当前经验值
 */
@property (nonatomic, assign) int point;

	/**
用户/财富/主播 特权
 */
@property (nonatomic, strong) NSMutableArray<AppGradePrivilegeDTOModel*>* agpDTOList;

 +(NSMutableArray<AppUserPrivilegeDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserPrivilegeDTOModel*>*)list;

 +(AppUserPrivilegeDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppUserPrivilegeDTOModel*) source target:(AppUserPrivilegeDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
