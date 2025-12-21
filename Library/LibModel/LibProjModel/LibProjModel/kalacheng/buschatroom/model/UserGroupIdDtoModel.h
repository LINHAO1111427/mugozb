//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class AppIdBOModel;
NS_ASSUME_NONNULL_BEGIN




/**
list
 */
@interface UserGroupIdDtoModel : NSObject 


	/**
群组id
 */
@property (nonatomic, strong) NSMutableArray<AppIdBOModel*>* groupIdList;

	/**
用户id
 */
@property (nonatomic, strong) NSMutableArray<AppIdBOModel*>* userIdList;

 +(NSMutableArray<UserGroupIdDtoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserGroupIdDtoModel*>*)list;

 +(UserGroupIdDtoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(UserGroupIdDtoModel*) source target:(UserGroupIdDtoModel*)target;

@end

NS_ASSUME_NONNULL_END
