//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户资料审核VO(个人中心)
 */
@interface AppUserDataReviewVOModel : NSObject 


	/**
审核状态 -1:审核拒绝 0:审核中 1:审核通过
 */
@property (nonatomic, assign) int approvalStatus;

	/**
资料类型
 */
@property (nonatomic, assign) int dataType;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
用户ID
 */
@property (nonatomic, assign) int64_t userId;

	/**
更新的用户资料(例如图片/签名等)
 */
@property (nonatomic, copy) NSString * upUserContent;

	/**
旧的用户资料(例如图片签名等)
 */
@property (nonatomic, copy) NSString * oldUserContent;

 +(NSMutableArray<AppUserDataReviewVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AppUserDataReviewVOModel*>*)list;

 +(AppUserDataReviewVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AppUserDataReviewVOModel*) source target:(AppUserDataReviewVOModel*)target;

@end

NS_ASSUME_NONNULL_END
