//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class LogisticsBeanModel;
NS_ASSUME_NONNULL_BEGIN




/**
物流信息
 */
@interface ShopLogisticsDTOModel : NSObject 


	/**
物流信息
 */
@property (strong, nonatomic) LogisticsBeanModel* logisticsBean;

	/**
可用物流列表
 */
@property (nonatomic, strong) NSMutableArray<NSString *>* logisticsList;

 +(NSMutableArray<ShopLogisticsDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopLogisticsDTOModel*>*)list;

 +(ShopLogisticsDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopLogisticsDTOModel*) source target:(ShopLogisticsDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
