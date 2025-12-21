//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class LogisticsNodeDTOModel;
NS_ASSUME_NONNULL_BEGIN




/**
快递信息model
 */
@interface ApiShopLogisticsDTOModel : NSObject 


	/**
快递单号
 */
@property (nonatomic, copy) NSString * number;

	/**
快递名称
 */
@property (nonatomic, copy) NSString * expName;

	/**
快递物流信息
 */
@property (nonatomic, strong) NSMutableArray<LogisticsNodeDTOModel*>* nodeList;

 +(NSMutableArray<ApiShopLogisticsDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiShopLogisticsDTOModel*>*)list;

 +(ApiShopLogisticsDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiShopLogisticsDTOModel*) source target:(ApiShopLogisticsDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
