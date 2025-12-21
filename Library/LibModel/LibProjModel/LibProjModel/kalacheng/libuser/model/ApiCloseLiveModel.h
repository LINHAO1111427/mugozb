//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
APP关闭直播间响应
 */
@interface ApiCloseLiveModel : NSObject 


	/**
直播时长(秒)
 */
@property (nonatomic, assign) int64_t duration;

	/**
打赏人数
 */
@property (nonatomic, assign) int rewardNumber;

	/**
新增关注人数
 */
@property (nonatomic, assign) int addFollow;

	/**
加入粉丝团人数
 */
@property (nonatomic, assign) int addFansGroup;

	/**
收益
 */
@property (nonatomic, assign) double votes;

	/**
用户头像
 */
@property (nonatomic, copy) NSString * avatar;

	/**
主播id
 */
@property (nonatomic, assign) int64_t anchorId;

	/**
主播名称
 */
@property (nonatomic, copy) NSString * anchorName;

	/**
关播时人数
 */
@property (nonatomic, assign) int nums;

	/**
房间号
 */
@property (nonatomic, assign) int64_t roomId;

 +(NSMutableArray<ApiCloseLiveModel*>*)getFromArr:(NSArray*)list;

 -(NSDictionary*)modelToJSONObject;

 +(NSMutableArray*)modelToJSONArray:(NSMutableArray<ApiCloseLiveModel*>*)list;

 +(ApiCloseLiveModel*)getFromDict:(NSDictionary*)dict;

 +(void)cloneObj:(ApiCloseLiveModel*) source target:(ApiCloseLiveModel*)target;

@end

NS_ASSUME_NONNULL_END
