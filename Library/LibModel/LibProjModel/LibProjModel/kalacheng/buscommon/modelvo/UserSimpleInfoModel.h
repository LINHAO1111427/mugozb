//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
用户贵族/svip 信息
 */
@interface UserSimpleInfoModel : NSObject 


	/**
用户id
 */
@property (nonatomic, assign) int64_t userid;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

	/**
贵族等级
 */
@property (nonatomic, assign) int nobleGrade;

	/**
畅看私密图特权 1:有 0：没有
 */
@property (nonatomic, assign) int CksmtTPrivilege;

	/**
用户是否开通svip 1:是 0:否
 */
@property (nonatomic, assign) int isSvip;

 +(NSMutableArray<UserSimpleInfoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserSimpleInfoModel*>*)list;

 +(UserSimpleInfoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(UserSimpleInfoModel*) source target:(UserSimpleInfoModel*)target;

@end

NS_ASSUME_NONNULL_END
