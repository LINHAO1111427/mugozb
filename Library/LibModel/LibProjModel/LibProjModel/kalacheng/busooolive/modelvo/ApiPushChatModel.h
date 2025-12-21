//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP抢聊列表
 */
@interface ApiPushChatModel : NSObject 


	/**
用户在线状态 0:离线 1:在线
 */
@property (nonatomic, assign) int onlineStatus;

	/**
用户等级
 */
@property (nonatomic, copy) NSString * userGradeImg;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
sessionID
 */
@property (nonatomic, assign) int64_t sessionID;

	/**
主播id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
话费id
 */
@property (nonatomic, assign) int64_t feeId;

	/**
用户id
 */
@property (nonatomic, assign) int64_t userId;

	/**
查询内容
 */
@property (nonatomic, copy) NSString * search;

	/**
发布时间
 */
@property (nonatomic,copy) NSDate * createTime;

	/**
一对一 一级频道id
 */
@property (nonatomic, assign) int64_t oooChannelId;

	/**
null
 */
@property (nonatomic, assign) int64_t id_field;

	/**
聊天类型 1:视频聊天 2:语音聊天
 */
@property (nonatomic, assign) int chatType;

	/**
话费金额/分钟
 */
@property (nonatomic, assign) int coin;

	/**
状态 0:发布中 1:通话中 2:已结束
 */
@property (nonatomic, assign) int status;

	/**
用户贵族
 */
@property (nonatomic, copy) NSString * userNobleImg;

	/**
用户名
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<ApiPushChatModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiPushChatModel*>*)list;

 +(ApiPushChatModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiPushChatModel*) source target:(ApiPushChatModel*)target;

@end

NS_ASSUME_NONNULL_END
