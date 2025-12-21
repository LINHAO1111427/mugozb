//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class ApiUserInfoModel;
 @class GiftWallDtoModel;
NS_ASSUME_NONNULL_BEGIN




/**
我的账户相关
 */
@interface UserInfoLiveVOModel : NSObject 


	/**
用户信息
 */
@property (strong, nonatomic) ApiUserInfoModel* userInfo;

	/**
关注状态 0:未关注， 1：已关注
 */
@property (nonatomic, assign) int isAttentionUser;

	/**
关注我的数量（粉丝数量）
 */
@property (nonatomic, assign) int fansNum;

	/**
我关注的数量
 */
@property (nonatomic, assign) int followNum;

	/**
是否禁言 1:已禁言 0:未禁言
 */
@property (nonatomic, assign) int isShutUp;

	/**
总收益映票(展示)
 */
@property (nonatomic, copy) NSString * totalIncomeVotesStr;

	/**
对方用户跟直播间的关系 1:当前直播间主播 2:管理员 3:普通用户
 */
@property (nonatomic, assign) int toRelation;

	/**
是否拉黑 0:未拉黑 1:拉黑
 */
@property (nonatomic, assign) int isPullBlack;

	/**
总消费金币(展示)
 */
@property (nonatomic, copy) NSString * totalConsumeCoinStr;

	/**
礼物墙
 */
@property (nonatomic, strong) NSMutableArray<GiftWallDtoModel*>* giftWall;

	/**
是否在麦位上（主持位或普通麦位） 0：不在麦位上 1：在麦位上 
 */
@property (nonatomic, assign) int inAssistant;

	/**
当前用户跟直播间的关系 1:当前直播间主播 2:管理员 3:普通用户
 */
@property (nonatomic, assign) int relation;

 +(NSMutableArray<UserInfoLiveVOModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<UserInfoLiveVOModel*>*)list;

 +(UserInfoLiveVOModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(UserInfoLiveVOModel*) source target:(UserInfoLiveVOModel*)target;

@end

NS_ASSUME_NONNULL_END
