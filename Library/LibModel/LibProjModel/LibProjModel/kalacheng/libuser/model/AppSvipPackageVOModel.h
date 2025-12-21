//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class CfgPayWayDTOModel;
NS_ASSUME_NONNULL_BEGIN




/**
svip各套餐明细
 */
@interface AppSvipPackageVOModel : NSObject 


	/**
苹果项目id
 */
@property (nonatomic, copy) NSString * iosId;

	/**
支付类型 1:金币 2:RMB，3.人民币/金币
 */
@property (nonatomic, assign) int payType;

	/**
ios价格
 */
@property (nonatomic, assign) double iosPrice;

	/**
套餐名称
 */
@property (nonatomic, copy) NSString * name;

	/**
安卓价格
 */
@property (nonatomic, assign) double androidPrice;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
支付方式
 */
@property (nonatomic, strong) NSMutableArray<CfgPayWayDTOModel*>* payList;

	/**
套餐时长
 */
@property (nonatomic, assign) int time;

	/**
套餐时长单位
 */
@property (nonatomic, copy) NSString * timeUnits;

	/**
金币价格
 */
@property (nonatomic, assign) double coin;

 +(NSMutableArray<AppSvipPackageVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSvipPackageVOModel*>*)list;

 +(AppSvipPackageVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppSvipPackageVOModel*) source target:(AppSvipPackageVOModel*)target;

@end

NS_ASSUME_NONNULL_END
