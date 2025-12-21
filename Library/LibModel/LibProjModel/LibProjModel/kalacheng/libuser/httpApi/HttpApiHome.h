//此代码由 http://code.siwaha.com/ 生成，服务器修改后可重新生成
#import <Foundation/Foundation.h>

#import <LibProjBase/PageInfo.h>


#import "AppHomeHallDTOModel.h"

#import "Home_getHomeDataList.h"
#import "AppAreaModel.h"

#import "HomeDtoModel.h"

#import "AppLiveChannelModel.h"

#import "HomeO2ODataModel.h"

#import "Home_getHomO2ODataList.h"
#import "SearchConditionDtoModel.h"

#import "SlideLiveRoomVOModel.h"

#import "Home_getLiveListAtPosition.h"
typedef void (^CallBackHome_AppHomeHallDTOArr)(int code,NSString *strMsg,NSArray<AppHomeHallDTOModel*>* arr);
typedef void (^CallBackHome_AppAreaArr)(int code,NSString *strMsg,NSArray<AppAreaModel*>* arr);
typedef void (^CallBackHome_AppHomeHallDTO)(int code,NSString *strMsg,AppHomeHallDTOModel* model);
typedef void (^CallBackHome_HomeDto)(int code,NSString *strMsg,HomeDtoModel* model);
typedef void (^CallBackHome_AppLiveChannelArr)(int code,NSString *strMsg,NSArray<AppLiveChannelModel*>* arr);
typedef void (^CallBackHome_HomeO2ODataArr)(int code,NSString *strMsg,NSArray<HomeO2ODataModel*>* arr);
typedef void (^CallBackHome_AppHomeHallDTOPageArr)(int code,NSString *strMsg,PageInfo *pageInfo,NSArray<AppHomeHallDTOModel*>* arr);
typedef void (^CallBackHome_SearchConditionDto)(int code,NSString *strMsg,SearchConditionDtoModel* model);
typedef void (^CallBackHome_SlideLiveRoomVO)(int code,NSString *strMsg,SlideLiveRoomVOModel* model);
NS_ASSUME_NONNULL_BEGIN



/**
首页接口
 */
@interface HttpApiHome: NSObject





/**
 首页列表数据
 @param address 地址
 @param channelId 频道ID(全部传-1)
 @param hotSortId 热门类型ID(没有传-1)
 @param isLive 是否正在直播 -1:全部 0:关播 1:开播
 @param isRecommend 是否推荐 -1:全部 0:不推荐 1:已推荐
 @param liveFunction 是否有直播购 -1:全部 0:没有 1:有
 @param liveType 类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param sex 性别 -1:全部 0:默认未设置性别的用户 1:男 2:女
 @param tabIds 标签ID数组， 逗号隔开
 @param twoClassifyId ooo二级分类id(没有就-1)
 */
+(void) getHomeDataList:(Home_getHomeDataList*)_mdl callback:(CallBackHome_AppHomeHallDTOArr)callback;
/**
 首页列表数据
 @param address 地址
 @param channelId 频道ID(全部传-1)
 @param hotSortId 热门类型ID(没有传-1)
 @param isLive 是否正在直播 -1:全部 0:关播 1:开播
 @param isRecommend 是否推荐 -1:全部 0:不推荐 1:已推荐
 @param liveFunction 是否有直播购 -1:全部 0:没有 1:有
 @param liveType 类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param sex 性别 -1:全部 0:默认未设置性别的用户 1:男 2:女
 @param tabIds 标签ID数组， 逗号隔开
 @param twoClassifyId ooo二级分类id(没有就-1)
 */
+(void) getHomeDataList:(NSString *)address channelId:(int64_t)channelId hotSortId:(int64_t)hotSortId isLive:(int)isLive isRecommend:(int)isRecommend liveFunction:(int)liveFunction liveType:(int)liveType pageIndex:(int)pageIndex pageSize:(int)pageSize sex:(int)sex tabIds:(NSString *)tabIds twoClassifyId:(int64_t)twoClassifyId  callback:(CallBackHome_AppHomeHallDTOArr)callback;


/**
 获取附近搜索条件
 */
+(void) getNearbySearchCondition:(CallBackHome_AppAreaArr)callback;


/**
 首页数据信息(单个)
 @param liveType 类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 @param roomId 房间id
 */
+(void) getHomeDataInfo:(int)liveType roomId:(int64_t)roomId  callback:(CallBackHome_AppHomeHallDTO)callback;


/**
 首页广场直播头部数据
 @param type 类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态
 */
+(void) getHomeSquareLiveHeader:(int)type  callback:(CallBackHome_HomeDto)callback;


/**
 获取直播频道
 @param type 类型 1:直播 2:语音 3:1v1 4:电台 5:派对
 */
+(void) getLiveChannel:(int)type  callback:(CallBackHome_AppLiveChannelArr)callback;




/**
 首页列表数据
 @param address 地址
 @param channelId 频道ID
 @param hotSortId 热门类型ID
 @param isRecommend 是否推荐 -1:全部 0:不推荐 1:已推荐
 @param lat 纬度
 @param lng 经度
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param sex 性别 -1:全部 0:默认未设置性别的用户 1:男 2:女
 @param tabIds 标签ID数组， 逗号隔开
 @param twoClassifyId ooo二级分类id(没有就-1)
 */
+(void) getHomO2ODataList:(Home_getHomO2ODataList*)_mdl callback:(CallBackHome_HomeO2ODataArr)callback;
/**
 首页列表数据
 @param address 地址
 @param channelId 频道ID
 @param hotSortId 热门类型ID
 @param isRecommend 是否推荐 -1:全部 0:不推荐 1:已推荐
 @param lat 纬度
 @param lng 经度
 @param pageIndex 当前页
 @param pageSize 每页大小
 @param sex 性别 -1:全部 0:默认未设置性别的用户 1:男 2:女
 @param tabIds 标签ID数组， 逗号隔开
 @param twoClassifyId ooo二级分类id(没有就-1)
 */
+(void) getHomO2ODataList:(NSString *)address channelId:(int64_t)channelId hotSortId:(int64_t)hotSortId isRecommend:(int)isRecommend lat:(double)lat lng:(double)lng pageIndex:(int)pageIndex pageSize:(int)pageSize sex:(int)sex tabIds:(NSString *)tabIds twoClassifyId:(int64_t)twoClassifyId  callback:(CallBackHome_HomeO2ODataArr)callback;


/**
 首页关注列表
 @param liveType 直播类型 1:视频 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 (查全部时，传-1， 现在只支持视频、语音)
 @param page 当前页
 @param pageSize 每页的条数
 */
+(void) lobbyAttention:(int)liveType page:(int)page pageSize:(int)pageSize  callback:(CallBackHome_AppHomeHallDTOPageArr)callback;


/**
 获取首页一对一搜索条件
 */
+(void) getO2OSearchCondition:(CallBackHome_SearchConditionDto)callback;




/**
 获取正在直播的列表（某个位置的数据）
 @param channelId 频道ID(全部传-1)
 @param city 城市筛选 没有指定城市就传空字符串
 @param findType 查询类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 8:附近 9:公会
 @param guildId 公会id
 @param hotSortId 热门类型ID(没有传-1)
 @param isAttention 关注 0:不关注 1:关注
 @param isRecommend 是否推荐(如果只是查推荐数据,这里就传 1) -1:全部 0:不推荐 1:已推荐
 @param pageIndex 当前页
 @param pageSize 每页的条数
 @param roomId 当前所在房间
 */
+(void) getLiveListAtPosition:(Home_getLiveListAtPosition*)_mdl callback:(CallBackHome_SlideLiveRoomVO)callback;
/**
 获取正在直播的列表（某个位置的数据）
 @param channelId 频道ID(全部传-1)
 @param city 城市筛选 没有指定城市就传空字符串
 @param findType 查询类型 1:直播 2:语音 3:1v1 4:电台 5:派对 6:短视频 7:动态 8:附近 9:公会
 @param guildId 公会id
 @param hotSortId 热门类型ID(没有传-1)
 @param isAttention 关注 0:不关注 1:关注
 @param isRecommend 是否推荐(如果只是查推荐数据,这里就传 1) -1:全部 0:不推荐 1:已推荐
 @param pageIndex 当前页
 @param pageSize 每页的条数
 @param roomId 当前所在房间
 */
+(void) getLiveListAtPosition:(int64_t)channelId city:(NSString *)city findType:(int)findType guildId:(int64_t)guildId hotSortId:(int64_t)hotSortId isAttention:(int)isAttention isRecommend:(int)isRecommend pageIndex:(int)pageIndex pageSize:(int)pageSize roomId:(int64_t)roomId  callback:(CallBackHome_SlideLiveRoomVO)callback;

@end

NS_ASSUME_NONNULL_END
