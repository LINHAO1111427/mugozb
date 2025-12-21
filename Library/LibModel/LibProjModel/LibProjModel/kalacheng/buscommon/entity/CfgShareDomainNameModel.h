//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
分享域名列表
 */
@interface CfgShareDomainNameModel : NSObject 


	/**
是否禁用 1:是 0:否
 */
@property (nonatomic, assign) int isDisable;

	/**
创建时间
 */
@property (nonatomic,copy) NSDate * createTime;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
域名网址
 */
@property (nonatomic, copy) NSString * domainUrl;

	/**
备注
 */
@property (nonatomic, copy) NSString * remarks;

 +(NSMutableArray<CfgShareDomainNameModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<CfgShareDomainNameModel*>*)list;

 +(CfgShareDomainNameModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(CfgShareDomainNameModel*) source target:(CfgShareDomainNameModel*)target;

@end

NS_ASSUME_NONNULL_END
