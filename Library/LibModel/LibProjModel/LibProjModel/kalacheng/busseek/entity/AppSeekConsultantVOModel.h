//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
寻觅顾问认证信息VO
 */
@interface AppSeekConsultantVOModel : NSObject 


	/**
审核状态 0：待审核 1：审核通过 -1：审核拒绝
 */
@property (nonatomic, assign) int approvalStatus;

	/**
正面
 */
@property (nonatomic, copy) NSString * frontView;

	/**
审核备注
 */
@property (nonatomic, copy) NSString * approvalRemark;

	/**
手持
 */
@property (nonatomic, copy) NSString * handsetView;

	/**
反面
 */
@property (nonatomic, copy) NSString * backView;

	/**
审核时间
 */
@property (nonatomic,copy) NSDate * approvalTime;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

 +(NSMutableArray<AppSeekConsultantVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppSeekConsultantVOModel*>*)list;

 +(AppSeekConsultantVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppSeekConsultantVOModel*) source target:(AppSeekConsultantVOModel*)target;

@end

NS_ASSUME_NONNULL_END
