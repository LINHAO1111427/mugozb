//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppSvipPackageVOModel;
 @class SvipPrivilegeConfigVOModel;
NS_ASSUME_NONNULL_BEGIN




/**
svip各套餐明细
 */
@interface AppSvipVOModel : NSObject 


	/**
SVIP描述(这里是付款的那个)
 */
@property (nonatomic, copy) NSString * svipDescription;

	/**
SVIP说明(弹出框)
 */
@property (nonatomic, copy) NSString * notes;

	/**
svip服务套餐明细
 */
@property (nonatomic, strong) NSMutableArray<AppSvipPackageVOModel*>* svipPackages;

	/**
svip特权说明
 */
@property (nonatomic, strong) NSMutableArray<SvipPrivilegeConfigVOModel*>* svipPrivilegeConfigVO;

	/**
SVIP弹窗标题(弹出框)
 */
@property (nonatomic, copy) NSString * name;

	/**
到期天数
 */
@property (nonatomic, assign) int leftDays;

	/**
SVIP背景图(弹出框)
 */
@property (nonatomic, copy) NSString * picture;

 +(NSMutableArray<AppSvipVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSvipVOModel*>*)list;

 +(AppSvipVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppSvipVOModel*) source target:(AppSvipVOModel*)target;

@end

NS_ASSUME_NONNULL_END
