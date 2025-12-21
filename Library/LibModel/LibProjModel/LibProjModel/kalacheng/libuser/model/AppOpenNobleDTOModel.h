//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class CfgPayWayDTOModel;
 @class NobleCenterVipPriceDTOModel;
NS_ASSUME_NONNULL_BEGIN




/**
开通贵族支付方式和价格
 */
@interface AppOpenNobleDTOModel : NSObject 


	/**
我的等级
 */
@property (nonatomic, assign) int userGrade;

	/**
到期天数
 */
@property (nonatomic, assign) int endDay;

	/**
开通提醒
 */
@property (nonatomic, copy) NSString * openNoblePrompt;

	/**
支付方式集合
 */
@property (nonatomic, strong) NSMutableArray<CfgPayWayDTOModel*>* payWayList;

	/**
我图像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
我的贵族等级图片
 */
@property (nonatomic, copy) NSString * nobleGradeImg;

	/**
货币类型 金币，喵币之类
 */
@property (nonatomic, copy) NSString * coinUnit;

	/**
购买贵族的套餐名称
 */
@property (nonatomic, copy) NSString * noblePackageName;

	/**
价格集合
 */
@property (nonatomic, strong) NSMutableArray<NobleCenterVipPriceDTOModel*>* priceList;

 +(NSMutableArray<AppOpenNobleDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppOpenNobleDTOModel*>*)list;

 +(AppOpenNobleDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppOpenNobleDTOModel*) source target:(AppOpenNobleDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
