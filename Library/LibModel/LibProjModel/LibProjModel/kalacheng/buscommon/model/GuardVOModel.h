//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class CfgPayWayDTOModel;
NS_ASSUME_NONNULL_BEGIN




/**
守护
 */
@interface GuardVOModel : NSObject 


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
时长（单位：天）
 */
@property (nonatomic, assign) int length;

	/**
守护名称
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
金币价格
 */
@property (nonatomic, assign) double coin;

 +(NSMutableArray<GuardVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<GuardVOModel*>*)list;

 +(GuardVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(GuardVOModel*) source target:(GuardVOModel*)target;

@end

NS_ASSUME_NONNULL_END
