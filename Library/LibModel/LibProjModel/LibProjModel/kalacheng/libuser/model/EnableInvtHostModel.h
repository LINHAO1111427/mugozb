//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
1v1v7可邀请的主播返回信息
 */
@interface EnableInvtHostModel : NSObject 


	/**
ooo导航分类关联app_live_channel表
 */
@property (nonatomic, assign) int64_t headNo;

	/**
视频通话时间金币/min
 */
@property (nonatomic, assign) double videoCoin;

	/**
邀请状态 0未被邀请 3被邀请中
 */
@property (nonatomic, assign) int invited;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
贵族等级
 */
@property (nonatomic, assign) int nobleGrade;

	/**
海报
 */
@property (nonatomic, copy) NSString * poster;

	/**
主播用户id
 */
@property (nonatomic, assign) int64_t userid;

	/**
主播用户名
 */
@property (nonatomic, copy) NSString * username;

 +(NSMutableArray<EnableInvtHostModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<EnableInvtHostModel*>*)list;

 +(EnableInvtHostModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(EnableInvtHostModel*) source target:(EnableInvtHostModel*)target;

@end

NS_ASSUME_NONNULL_END
