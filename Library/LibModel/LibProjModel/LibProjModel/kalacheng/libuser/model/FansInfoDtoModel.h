//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

 @class KeyValueDtoModel;
 @class AppUserAvatarModel;
NS_ASSUME_NONNULL_BEGIN




/**
粉丝团信息
 */
@interface FansInfoDtoModel : NSObject 


	/**
特权
 */
@property (nonatomic, strong) NSMutableArray<KeyValueDtoModel*>* privileges;

	/**
粉丝数量
 */
@property (nonatomic, assign) int fansNum;

	/**
粉丝团创建与否  0：未创建 1：已创建
 */
@property (nonatomic, assign) int isCreate;

	/**
主播头像
 */
@property (nonatomic, copy) NSString * anchorAvatar;

	/**
粉丝团名称
 */
@property (nonatomic, copy) NSString * fansTeamName;

	/**
主播粉丝团群聊id
 */
@property (nonatomic, assign) int64_t groupId;

	/**
粉丝团头像
 */
@property (nonatomic, copy) NSString * fansTeamAvatar;

	/**
总打赏金币
 */
@property (nonatomic, assign) double totalCoin;

	/**
是否是粉丝团成员  0：不是 1：是
 */
@property (nonatomic, assign) int isMember;

	/**
主播id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
四位粉丝头像
 */
@property (nonatomic, strong) NSMutableArray<AppUserAvatarModel*>* avatars;

	/**
加入一个粉丝团所需金币
 */
@property (nonatomic, assign) double coin;

 +(NSMutableArray<FansInfoDtoModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<FansInfoDtoModel*>*)list;

 +(FansInfoDtoModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(FansInfoDtoModel*) source target:(FansInfoDtoModel*)target;

@end

NS_ASSUME_NONNULL_END
