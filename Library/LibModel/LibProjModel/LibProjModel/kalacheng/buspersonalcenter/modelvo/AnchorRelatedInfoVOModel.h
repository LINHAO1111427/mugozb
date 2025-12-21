//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiUsersLiveWishModel;
NS_ASSUME_NONNULL_BEGIN




/**
用户和主播关联的一些信息
 */
@interface AnchorRelatedInfoVOModel : NSObject 


	/**
是否是守护 0:不是守护 1:是守护
 */
@property (nonatomic, assign) int isGuard;

	/**
是否被用户关注 0:未关注 1:关注
 */
@property (nonatomic, assign) int isAtten;

	/**
是否是粉丝 0:不是粉丝 1:是粉丝
 */
@property (nonatomic, assign) int isFans;

	/**
是否是贵族 0:不是贵族 1:是贵族
 */
@property (nonatomic, assign) int isNoble;

	/**
心愿单
 */
@property (nonatomic, strong) NSMutableArray<ApiUsersLiveWishModel*>* apiUsersLiveWishList;

	/**
火力值
 */
@property (nonatomic, assign) double hotVotes;

	/**
用户名称
 */
@property (nonatomic, copy) NSString * userName;

 +(NSMutableArray<AnchorRelatedInfoVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<AnchorRelatedInfoVOModel*>*)list;

 +(AnchorRelatedInfoVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(AnchorRelatedInfoVOModel*) source target:(AnchorRelatedInfoVOModel*)target;

@end

NS_ASSUME_NONNULL_END
