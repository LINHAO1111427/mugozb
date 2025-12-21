//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
协议返回
 */
@interface AppMerchantAgreementDTOModel : NSObject 


	/**
post内容
 */
@property (nonatomic, copy) NSString * postExcerpt;

	/**
post标题
 */
@property (nonatomic, copy) NSString * postTitle;

	/**
审核备注
 */
@property (nonatomic, copy) NSString * remake;

	/**
状态 0:没有申请 1:审核中 2.审核通过 3.审核拒绝 4.冻结
 */
@property (nonatomic, assign) int status;

 +(NSMutableArray<AppMerchantAgreementDTOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppMerchantAgreementDTOModel*>*)list;

 +(AppMerchantAgreementDTOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppMerchantAgreementDTOModel*) source target:(AppMerchantAgreementDTOModel*)target;

@end

NS_ASSUME_NONNULL_END
