//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
申请退款原因model
 */
@interface ApplyRefundReasonDTOModel : NSObject 


	/**
退款原因
 */
@property (nonatomic, copy) NSString * reason;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
序号
 */
@property (nonatomic, assign) int sort;

 +(NSMutableArray<ApplyRefundReasonDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApplyRefundReasonDTOModel*>*)list;

 +(ApplyRefundReasonDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApplyRefundReasonDTOModel*) source target:(ApplyRefundReasonDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
