//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiUserInfoModel;
NS_ASSUME_NONNULL_BEGIN




/**
获取用户信息及与该用户的关系
 */
@interface UserInfoRelationVO2Model : NSObject 


	/**
用户信息
 */
@property (strong, nonatomic) ApiUserInfoModel* userInfo;

	/**
关注状态 0:未关注， 1：已关注
 */
@property (nonatomic, assign) int isAttentionUser;

 +(NSMutableArray<UserInfoRelationVO2Model*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserInfoRelationVO2Model*>*)list;

 +(UserInfoRelationVO2Model*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(UserInfoRelationVO2Model*) source target:(UserInfoRelationVO2Model*)target;

@end

NS_ASSUME_NONNULL_END
