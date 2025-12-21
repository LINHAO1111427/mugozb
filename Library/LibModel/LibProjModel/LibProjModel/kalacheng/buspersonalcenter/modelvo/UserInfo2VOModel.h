//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiUserInfoModel;
 @class UserInterestTabVOModel;
 @class GiftWallDtoModel;
 @class AppMedalModel;
NS_ASSUME_NONNULL_BEGIN




/**
我的账户相关
 */
@interface UserInfo2VOModel : NSObject 


	/**
用户信息
 */
@property (strong, nonatomic) ApiUserInfoModel* userInfo;

	/**
我的兴趣标签列表展示
 */
@property (nonatomic, strong) NSMutableArray<UserInterestTabVOModel*>* myInterestList;

	/**
礼物墙
 */
@property (nonatomic, strong) NSMutableArray<GiftWallDtoModel*>* giftWall;

	/**
用户勋章-勋章墙3个
 */
@property (nonatomic, strong) NSMutableArray<AppMedalModel*>* medalWall;

 +(NSMutableArray<UserInfo2VOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserInfo2VOModel*>*)list;

 +(UserInfo2VOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(UserInfo2VOModel*) source target:(UserInfo2VOModel*)target;

@end

NS_ASSUME_NONNULL_END
