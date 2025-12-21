//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
预估订单退货流程model
 */
@interface ShopOrderReturnProcessDTOModel : NSObject 


	/**
节点名称
 */
@property (nonatomic, copy) NSString * nodeName;

	/**
变更时间
 */
@property (nonatomic,copy) NSDate * upTime;

	/**
节点序号
 */
@property (nonatomic, assign) int nodeNo;

	/**
是否操作 0：待操作; 1:已操作
 */
@property (nonatomic, assign) int operateStatus;

	/**
订单号
 */
@property (nonatomic, copy) NSString * orderNo;

	/**
节点状态 0：正常; 1:失效
 */
@property (nonatomic, assign) int nodeStatus;

 +(NSMutableArray<ShopOrderReturnProcessDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ShopOrderReturnProcessDTOModel*>*)list;

 +(ShopOrderReturnProcessDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ShopOrderReturnProcessDTOModel*) source target:(ShopOrderReturnProcessDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
