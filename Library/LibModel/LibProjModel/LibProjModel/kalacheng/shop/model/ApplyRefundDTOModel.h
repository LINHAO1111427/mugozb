//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApplyRefundReasonDTOModel;
NS_ASSUME_NONNULL_BEGIN




/**
申请退款model
 */
@interface ApplyRefundDTOModel : NSObject 


	/**
退款总金额
 */
@property (nonatomic, assign) double amount;

	/**
退款原因集合
 */
@property (nonatomic, strong) NSMutableArray<ApplyRefundReasonDTOModel*>* reasonList;

 +(NSMutableArray<ApplyRefundDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApplyRefundDTOModel*>*)list;

 +(ApplyRefundDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApplyRefundDTOModel*) source target:(ApplyRefundDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
