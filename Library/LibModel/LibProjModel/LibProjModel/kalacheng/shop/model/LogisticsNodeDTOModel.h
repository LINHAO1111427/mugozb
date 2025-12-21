//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
快递节点信息
 */
@interface LogisticsNodeDTOModel : NSObject 


	/**
快递员 或 快递站(没有则为空)
 */
@property (nonatomic, copy) NSString * courier;

	/**
快递员电话 (没有则为空)
 */
@property (nonatomic, copy) NSString * courierPhone;

	/**
快递时间节点
 */
@property (nonatomic,copy) NSDate * time;

	/**
物流信息
 */
@property (nonatomic, copy) NSString * content;

	/**
快递状态：0：快递收件(揽件)1.在途中 2.正在派件 3.已签收 4.派送失败 5.疑难件 6.退件签收
 */
@property (nonatomic, copy) NSString * deliveryStatus;

 +(NSMutableArray<LogisticsNodeDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<LogisticsNodeDTOModel*>*)list;

 +(LogisticsNodeDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(LogisticsNodeDTOModel*) source target:(LogisticsNodeDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
