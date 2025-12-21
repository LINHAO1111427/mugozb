//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiUserInfoModel;
NS_ASSUME_NONNULL_BEGIN




/**
APP登录接口返回值
 */
@interface ApiUserInfoMyHeadModel : NSObject 


	/**
主播审核状态
 */
@property (nonatomic, assign) int anchorAuditStatus;

	/**
谁看过我人数
 */
@property (nonatomic, assign) int readMeUsersNumber;

	/**
用户信息
 */
@property (strong, nonatomic) ApiUserInfoModel* userInfo;

	/**
关注我的数量（粉丝数量）
 */
@property (nonatomic, assign) int fansNum;

	/**
我关注的数量
 */
@property (nonatomic, assign) int followNum;

	/**
谁看过我是否需要贵族开关 0:需要 1:不需要
 */
@property (nonatomic, assign) int isVipSee;

	/**
我的收藏
 */
@property (nonatomic, assign) int collectNum;

	/**
主播审核原因
 */
@property (nonatomic, copy) NSString * anchorAuditReason;

	/**
svip剩余天数
 */
@property (nonatomic, assign) int svipExpireDay;

	/**
电视剧总数量（购买，收藏，观看）
 */
@property (nonatomic, assign) int televisionNum;

	/**
贵族剩余天数
 */
@property (nonatomic, assign) int64_t nobleExpireDay;

	/**
点赞数
 */
@property (nonatomic, assign) int likeNum;

 +(NSMutableArray<ApiUserInfoMyHeadModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiUserInfoMyHeadModel*>*)list;

 +(ApiUserInfoMyHeadModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiUserInfoMyHeadModel*) source target:(ApiUserInfoMyHeadModel*)target;

@end

NS_ASSUME_NONNULL_END
