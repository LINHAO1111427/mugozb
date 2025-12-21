//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/**
 * 获取正在直播的列表（某个位置的数据）
*/
@interface Home_getLiveListAtPosition : NSObject 


 +(Home_getLiveListAtPosition*)getFromDict:(NSDictionary*)dict;

 +(NSMutableArray<Home_getLiveListAtPosition*>*)getFromArr:(NSArray*)list;


	
	/**
频道ID(全部传-1)
 */
@property (nonatomic, assign) int64_t channelId;


	
	/**
城市筛选 没有指定城市就传空字符串
 */
@property (nonatomic, copy) NSString * city;


	
	/**
查询类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 8:附近 9:公会
 */
@property (nonatomic, assign) int findType;


	
	/**
公会id
 */
@property (nonatomic, assign) int64_t guildId;


	
	/**
热门类型ID(没有传-1)
 */
@property (nonatomic, assign) int64_t hotSortId;


	
	/**
关注 0:不关注 1:关注
 */
@property (nonatomic, assign) int isAttention;


	
	/**
是否推荐(如果只是查推荐数据,这里就传 1) -1:全部 0:不推荐 1:已推荐
 */
@property (nonatomic, assign) int isRecommend;


	
	/**
当前页
 */
@property (nonatomic, assign) int pageIndex;


	
	/**
每页的条数
 */
@property (nonatomic, assign) int pageSize;


	
	/**
当前所在房间
 */
@property (nonatomic, assign) int64_t roomId;

@end

NS_ASSUME_NONNULL_END
